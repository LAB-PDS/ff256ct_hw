/*
Calculus of X_out[n] = F256CT[n,:]*x_in[:]
*/
`include "./verilog_files/ff256_cosine_transform/ff256_cosine_transform_defines.sv"

module ff256_cosine_transform_direct
#(
    parameter logic [7:0] betas [0:7][0:7] =  FF256CT_I_ROW_0
)
(
    input  [63:0]  x_in,
    output [7 :0]  x_out
);

// INTERNAL SIGNALS ################################
wire [7:0] x_0_i, x_1_i, x_2_i, x_3_i, x_4_i, x_5_i, x_6_i, x_7_i; //input of the multipliers
wire [7:0] x_0_o, x_1_o, x_2_o, x_3_o, x_4_o, x_5_o, x_6_o, x_7_o; //output of the multipliers


// INTERNAL LOGIC ##################################

assign x_0_i  = x_in[ 7: 0];
assign x_1_i  = x_in[15: 8];
assign x_2_i  = x_in[23:16];
assign x_3_i  = x_in[31:24];
assign x_4_i  = x_in[39:32];
assign x_5_i  = x_in[47:40];
assign x_6_i  = x_in[55:48];
assign x_7_i  = x_in[63:56];

// Define x_out:

assign x_out = x_0_o ^ x_1_o ^ x_2_o ^ x_3_o ^ x_4_o ^ x_5_o ^ x_6_o ^ x_7_o;
				

// ##################################################
// INSTANCES

ff256_mult_by_const_multiplier #(.cnst(betas[0])) ff256ct_n0_inst(
    .p_in (x_0_i),
    .p_out(x_0_o)
);

ff256_mult_by_const_multiplier #(.cnst(betas[1])) ff256ct_n1_inst(
    .p_in (x_1_i),
    .p_out(x_1_o)
);

ff256_mult_by_const_multiplier #(.cnst(betas[2])) ff256ct_n2_inst(
    .p_in (x_2_i),
    .p_out(x_2_o)
);

ff256_mult_by_const_multiplier #(.cnst(betas[3])) ff256ct_n3_inst(
    .p_in (x_3_i),
    .p_out(x_3_o)
);

ff256_mult_by_const_multiplier #(.cnst(betas[4])) ff256ct_n4_inst(
    .p_in (x_4_i),
    .p_out(x_4_o)
);

ff256_mult_by_const_multiplier #(.cnst(betas[5])) ff256ct_n5_inst(
    .p_in (x_5_i),
    .p_out(x_5_o)
);

ff256_mult_by_const_multiplier #(.cnst(betas[6])) ff256ct_n6_inst(
    .p_in (x_6_i),
    .p_out(x_6_o)
);

ff256_mult_by_const_multiplier #(.cnst(betas[7])) ff256ct_n7_inst(
    .p_in (x_7_i),
    .p_out(x_7_o)
);
    
endmodule 
