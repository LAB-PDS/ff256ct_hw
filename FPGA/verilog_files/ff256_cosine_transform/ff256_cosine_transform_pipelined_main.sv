`include "./verilog_files/ff256_cosine_transform/ff256_cosine_transform_defines.sv"

module ff256_cosine_transform_pipelined_main
    #(      
        parameter logic [7:0] FF256CT [0:7][0:7][0:7] = FF256CT_I,
        parameter  BUS_WIDTH  = 1,
        parameter  DATA_WIDTH = 32,
        parameter  BE_WIDTH   = 4
    )
    (
    //Common signal:
    input clk, 
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
    output [1:0]            status_o
    ); 

// INTERNAL SIGNALS ################################
wire [63:0] x_in; //it concatenates the two registers to form the x_in 
wire [ 7:0] ff256ct_0_o, ff256ct_1_o, ff256ct_2_o, ff256ct_3_o, ff256ct_4_o, ff256ct_5_o, ff256ct_6_o, ff256ct_7_o; //eache one of the X_out values

// INTERNAL REGS ###################################
reg [DATA_WIDTH-1:0] data_i_reg [1:0];

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
        if((adr_i == 1'b0) && (we_i))
        begin
            data_i_reg[0] <= data_i;
        end
        if((adr_i == 1'b1) && (we_i))
        begin
            data_i_reg[1] <= data_i;
        end
    end
end

// Define x_in:

assign x_in = {data_i_reg[1],data_i_reg[0]};

// Define data_o:

assign data_o = (adr_i == 1'b0)? {ff256ct_3_o, ff256ct_2_o, ff256ct_1_o, ff256ct_0_o}:
                                 {ff256ct_7_o, ff256ct_6_o, ff256ct_5_o, ff256ct_4_o};
				

// ##################################################
// INSTANCES


ff256_cosine_transform_pipelined #(.betas(FF256CT[0])) ff256ct_0_inst(
    .clk  (clk  ),
    .reset  (reset),
    .x_in (x_in),
    .x_out(ff256ct_0_o)
);

ff256_cosine_transform_pipelined #(.betas(FF256CT[1])) ff256ct_1_inst(
    .clk  (clk  ),
    .reset  (reset),
    .x_in (x_in),
    .x_out(ff256ct_1_o)
);

ff256_cosine_transform_pipelined #(.betas(FF256CT[2])) ff256ct_2_inst(
    .clk  (clk  ),
    .reset  (reset),
    .x_in (x_in),
    .x_out(ff256ct_2_o)
);

ff256_cosine_transform_pipelined #(.betas(FF256CT[3])) ff256ct_3_inst(
    .clk  (clk  ),
    .reset  (reset),
    .x_in (x_in),
    .x_out(ff256ct_3_o)
);

ff256_cosine_transform_pipelined #(.betas(FF256CT[4])) ff256ct_4_inst(
    .clk  (clk  ),
    .reset  (reset),
    .x_in (x_in),
    .x_out(ff256ct_4_o)
);

ff256_cosine_transform_pipelined #(.betas(FF256CT[5])) ff256ct_5_inst(
    .clk  (clk  ),
    .reset  (reset),
    .x_in (x_in),
    .x_out(ff256ct_5_o)
);

ff256_cosine_transform_pipelined #(.betas(FF256CT[6])) ff256ct_6_inst(
    .clk  (clk  ),
    .reset  (reset),
    .x_in (x_in),
    .x_out(ff256ct_6_o)
);

ff256_cosine_transform_pipelined #(.betas(FF256CT[7])) ff256ct_7_inst(
    .clk  (clk  ),
    .reset  (reset),
    .x_in (x_in),
    .x_out(ff256ct_7_o)
);

endmodule