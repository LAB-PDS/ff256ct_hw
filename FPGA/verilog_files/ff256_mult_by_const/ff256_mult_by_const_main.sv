`include "./verilog_files/ff256_mult_by_const/ff256_mult_by_const_defines.sv"

module ff256_mult_by_const_main
    #(               
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
    input                   cyc_i   //Cycle Output
    ); 

// INTERNAL SIGNALS ################################
wire [7:0] beta_1_data_i, beta_2_data_i, beta_3_data_i, beta_4_data_i, beta_6_data_i, beta_8_data_i, beta_9_data_i, beta_12_data_i;
wire [7:0] beta_1_data_o, beta_2_data_o, beta_3_data_o, beta_4_data_o, beta_6_data_o, beta_8_data_o, beta_9_data_o, beta_12_data_o;


// INTERNAL REGS ###################################
reg [DATA_WIDTH-1:0] data_i_reg [1:0];
reg [63:0] x_out;

// INTERNAL LOGIC ##################################

assign beta_1_data_i  = data_i_reg[0][ 7: 0];
assign beta_2_data_i  = data_i_reg[0][15: 8];
assign beta_3_data_i  = data_i_reg[0][23:16];
assign beta_4_data_i  = data_i_reg[0][31:24];
assign beta_6_data_i  = data_i_reg[1][ 7: 0];
assign beta_8_data_i  = data_i_reg[1][15: 8];
assign beta_9_data_i  = data_i_reg[1][23:16];
assign beta_12_data_i = data_i_reg[1][31:24];

//Update register
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

//Update registers
always @(posedge clk, negedge reset)
begin
    if(reset == 1'b0)
    begin
        x_out <= 64'd0;
    end 
    else 
    begin
        x_out[ 7: 0] <= beta_1_data_o;
        x_out[15: 8] <= beta_2_data_o;
        x_out[23:16] <= beta_3_data_o;
        x_out[31:24] <= beta_4_data_o;
        x_out[39:32] <= beta_6_data_o;
        x_out[47:40] <= beta_8_data_o;
        x_out[55:48] <= beta_9_data_o;
        x_out[63:56] <= beta_12_data_o;
    end
end

// Define data_o:

// assign data_o = (adr_i == 1'b0)? {beta_4_data_o, beta_3_data_o,beta_2_data_o,beta_1_data_o}:
//                                  {beta_12_data_o,beta_9_data_o,beta_8_data_o,beta_6_data_o};
				
assign data_o = (adr_i == 1'b0)? x_out[31: 0]:
                                 x_out[63:32];

// ##################################################
// INSTANCES

ff256_mult_by_const_multiplier 
#(
    .cnst(BETA_1)
) beta_1_inst(
    .p_in (beta_1_data_i),
    .p_out(beta_1_data_o)
);

 ff256_mult_by_const_multiplier #(.cnst(BETA_2)) beta_2_inst(
     .p_in (beta_2_data_i),
     .p_out(beta_2_data_o)
 );

 ff256_mult_by_const_multiplier #(.cnst(BETA_3)) beta_3_inst(
     .p_in (beta_3_data_i),
     .p_out(beta_3_data_o)
 );

 ff256_mult_by_const_multiplier #(.cnst(BETA_4)) beta_4_inst(
     .p_in (beta_4_data_i),
     .p_out(beta_4_data_o)
 );

 ff256_mult_by_const_multiplier #(.cnst(BETA_6)) beta_6_inst(
     .p_in (beta_6_data_i),
     .p_out(beta_6_data_o)
 );

 ff256_mult_by_const_multiplier #(.cnst(BETA_8)) beta_8_inst(
     .p_in (beta_8_data_i),
     .p_out(beta_8_data_o)
 );

 ff256_mult_by_const_multiplier #(.cnst(BETA_9)) beta_9_inst(
     .p_in (beta_9_data_i),
     .p_out(beta_9_data_o)
 );
 
  ff256_mult_by_const_multiplier #(.cnst(BETA_12)) beta_12_inst(
     .p_in (beta_12_data_i),
     .p_out(beta_12_data_o)
 );

endmodule