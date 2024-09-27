`include "./verilog_files/ff256_mult_by_const/ff256_mult_by_const_defines.sv"
`include "./verilog_files/ff256_cosine_transfom_sequential/ff256_ct_seq_defines.sv"

module ff256_ct_seq_main
    #(      
        parameter  BUS_WIDTH  = 3,
        parameter  DATA_WIDTH = 32,
        parameter  BE_WIDTH   = 4,
        parameter logic [2:0] SEL_CT_X [0:7][0:7] =  SEL_CTI
    )
    (
    //Common signal:
    input clk, 
    input clk_peripheral,
    input reset, 
    //Wishbone interface:
    input  [BUS_WIDTH-1:0]  adr_i,  //Address In
    input  [DATA_WIDTH-1:0] data_i, //Data In
    output [DATA_WIDTH-1:0] data_o, //Data Out
    input                   we_i,   //Write Enable In
    input  [BE_WIDTH-1:  0] sel_i,  //Select Input array
    input                   stb_i,  //Strobe In
    output                  ack_o,  //Acknowledged Out
    input                   cyc_i,  //Cycle Output
    output [4:0]            status_o
    ); 

// INTERNAL SIGNALS ################################
wire [63:0] x_in; //it concatenates the two registers to form the x_in 
wire [63:0] x_out;
reg  [63:0] x_beta_r;
reg  [63:0] x_mult_r;
wire [63:0] x_mult_out;
wire [ 7:0] x_beta_in [0: 7];
wire [ 2:0] selector  [0: 7];
wire [ 4:0] state;
wire [ 7:0] x_n_out;
wire [ 7:0] x_m_0, x_m_1, x_m_2, x_m_3, x_m_4, x_m_5, x_m_6, x_m_7; //eache one of the X_out values
reg  [ 7:0] x_o_0, x_o_1, x_o_2, x_o_3, x_o_4, x_o_5, x_o_6, x_o_7; //eache one of the X_out values

// INTERNAL REGS ###################################
reg [DATA_WIDTH-1:0] data_i_reg [1:0];
reg control_reg; //1 - iniciate the calculus 0 - come back to the idle state

// INTERNAL LOGIC ##################################

//Update registers
always @(posedge clk, negedge reset)
begin
    if(reset == 1'b0)
    begin
        data_i_reg[0] <= 32'd0;
        data_i_reg[1] <= 32'd0;
    end 
    else 
    begin
        if((adr_i == 3'b000) && (we_i))
        begin
            data_i_reg[0] <= data_i;
        end
        if((adr_i == 3'b001) && (we_i))
        begin
            data_i_reg[1] <= data_i;
        end
        if((adr_i == 3'b010) && (we_i))
        begin
            control_reg <= data_i[0];
        end
    end
end

// Define x_in:

assign x_in = {data_i_reg[1],data_i_reg[0]};

// Define data_o:

assign data_o = (adr_i == 3'b000)? data_i_reg[0]: 
                (adr_i == 3'b001)? data_i_reg[1]: 
                (adr_i == 3'b010)? {26'd0,state,output_ready}: 
                (adr_i == 3'b011)? x_out[31:0]: 
                (adr_i == 3'b100)? x_out[63:32]:
                                  {32'hAABBCCDD};

assign output_ready   = (state == `CT_SEQ_DONE)? 1'b1: 1'b0;


ff256_ct_seq_selector 
#(
    .index     (SEL_CT_X )
)
ff256_ct_seq_selector_int
(
    .clk       (clk     ),
    .reset     (reset   ),
    .state     (state   ),
    .selector  (selector)
);


ff256_ct_seq_mult_multiplexer ff256_ct_seq_mult_multiplexer_inst
(
    .selector   (selector),
    .x_in       (x_in),
    .x_beta_in  (x_beta_in)
);


always @(posedge clk, negedge reset)
begin
    if(reset == 1'b0)
    begin
        x_beta_r <= 64'd0;
    end 
    else 
    begin
        x_beta_r <= {x_beta_in[7], x_beta_in[6],x_beta_in[5], x_beta_in[4],x_beta_in[3], x_beta_in[2],x_beta_in[1], x_beta_in[0]};
    end
end

//MULTIPLIERS
ff256_ct_seq_multipliers #(.betas(MULT_ORDER)) ff256_ct_seq_multipliers_inst(
    .x_in  (x_beta_r),
    .x_out (x_mult_out)
);


always @(posedge clk, negedge reset)
begin
    if(reset == 1'b0)
    begin
        x_mult_r <= 64'd0;
    end 
    else 
    begin
        x_mult_r <= x_mult_out;
    end
end

assign x_m_0 = x_mult_r[ 7: 0];
assign x_m_1 = x_mult_r[15: 8];
assign x_m_2 = x_mult_r[23:16];
assign x_m_3 = x_mult_r[31:24];
assign x_m_4 = x_mult_r[39:32];
assign x_m_5 = x_mult_r[47:40];
assign x_m_6 = x_mult_r[55:48];
assign x_m_7 = x_mult_r[63:56];

assign x_n_out = x_m_0 ^ x_m_1 ^ x_m_2 ^ x_m_3 ^ x_m_4 ^ x_m_5 ^ x_m_6 ^ x_m_7;

always @(posedge clk, negedge reset) begin
    if (reset == 1'b0)
    begin
        x_o_0 <= 8'd0;
        x_o_1 <= 8'd0;
        x_o_2 <= 8'd0;
        x_o_3 <= 8'd0;
        x_o_4 <= 8'd0;
        x_o_5 <= 8'd0;
        x_o_6 <= 8'd0;
        x_o_7 <= 8'd0;
    end
    else
    begin
        // x_o_0 <= x_n_out;
        if (state !== `CT_SEQ_DONE)
        begin
            x_o_7 <= x_o_6;
            x_o_6 <= x_o_5;
            x_o_5 <= x_o_4;
            x_o_4 <= x_o_3;
            x_o_3 <= x_o_2;
            x_o_2 <= x_o_1;
            x_o_1 <= x_o_0;
            x_o_0 <= x_n_out;
        end
        else
        begin
            x_o_7 <= x_o_7;
            x_o_6 <= x_o_6;
            x_o_5 <= x_o_5;
            x_o_4 <= x_o_4;
            x_o_3 <= x_o_3;
            x_o_2 <= x_o_2;
            x_o_1 <= x_o_1;
            x_o_0 <= x_o_0;
        end
    end
end

assign x_out[ 7: 0] = x_o_7;
assign x_out[15: 8] = x_o_6;
assign x_out[23:16] = x_o_5;
assign x_out[31:24] = x_o_4;
assign x_out[39:32] = x_o_3;
assign x_out[47:40] = x_o_2;
assign x_out[55:48] = x_o_1;
assign x_out[63:56] = x_o_0;

//#################### SEQUENTIAL LOGIC

ff256_ct_seq_control ff256_ct_seq_control_inst
(
    .clk       (clk        ),
    .rst       (reset      ),
    .strt_cmpt (control_reg),
    .state_o   (state      )
);

endmodule
