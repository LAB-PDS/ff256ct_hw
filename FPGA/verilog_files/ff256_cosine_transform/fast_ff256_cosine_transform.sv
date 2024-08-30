/*
Optimized computation of X_out[:] = F256CT[:,:]*x_in[:].
x_in[:] shall be furnished sequentially in 8 clock cycle in the order x0, x1, x2..., x7.
*/
`include "./verilog_files/ff256_cosine_transform/ff256_cosine_transform_defines.sv"

module ff256_cosine_transform_direct
#(
    parameter logic [7:0] betas [0:7][0:7] =  FF256CT_I_ROW_0
)
(
    input  [7:0]  x_in,
    input clk,
    input strt_cmpt,
    output [63:0]  x_out,
    output output_ready
);

// INTERNAL SIGNALS ################################
reg [7:0] x_0_o, x_1_o, x_2_o, x_3_o, x_4_o, x_5_o, x_6_o, x_7_o; //output vector

// INTERNAL LOGIC ##################################

assign x_out[ 7: 0] = (output_ready?) x_0_o : 8'hz;
assign x_out[15: 8] = (output_ready?) x_1_o : 8'hz;
assign x_out[23:16] = (output_ready?) x_2_o : 8'hz;
assign x_out[31:24] = (output_ready?) x_3_o : 8'hz;
assign x_out[39:32] = (output_ready?) x_4_o : 8'hz;
assign x_out[47:40] = (output_ready?) x_5_o : 8'hz;
assign x_out[55:48] = (output_ready?) x_6_o : 8'hz;
assign x_out[63:56] = (output_ready?) x_7_o : 8'hz;

wire [7:0] beta_1_data_o, beta_2_data_o, beta_3_data_o, beta_4_data_o, beta_6_data_o, beta_8_data_o, beta_9_data_o, beta_12_data_o;

// ##################################################
// INSTANCES

ff256_mult_by_const_multiplier #(.cnst(BETA_1)) beta_1_inst(
    .p_in (x_in),
    .p_out(beta_1_data_o)
);

 ff256_mult_by_const_multiplier #(.cnst(BETA_2)) beta_2_inst(
     .p_in (x_in),
     .p_out(beta_2_data_o)
 );

 ff256_mult_by_const_multiplier #(.cnst(BETA_3)) beta_3_inst(
     .p_in (x_in),
     .p_out(beta_3_data_o)
 );

 ff256_mult_by_const_multiplier #(.cnst(BETA_4)) beta_4_inst(
     .p_in (x_in),
     .p_out(beta_4_data_o)
 );

 ff256_mult_by_const_multiplier #(.cnst(BETA_6)) beta_6_inst(
     .p_in (x_in),
     .p_out(beta_6_data_o)
 );

 ff256_mult_by_const_multiplier #(.cnst(BETA_8)) beta_8_inst(
     .p_in (x_in),
     .p_out(beta_8_data_o)
 );

 ff256_mult_by_const_multiplier #(.cnst(BETA_9)) beta_9_inst(
     .p_in (x_in),
     .p_out(beta_9_data_o)
 );
 
  ff256_mult_by_const_multiplier #(.cnst(BETA_12)) beta_12_inst(
     .p_in (x_in),
     .p_out(beta_12_data_o)
 );

//#################### SEQUENTIAL LOGIC

// TODO!!
    
endmodule 
