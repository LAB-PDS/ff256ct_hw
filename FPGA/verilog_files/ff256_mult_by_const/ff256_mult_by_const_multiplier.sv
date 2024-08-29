/*
Implementation of multiplication cnst * p_in = p_out in GF(2^8), where cnst is a constant
*/
`include "./verilog_files/ff256_mult_by_const/ff256_mult_by_const_defines.sv"

module ff256_mult_by_const_multiplier
#(
    parameter logic [7:0] cnst [0:7] =  '{8'h98, 8'h2d, 8'h5a, 8'hb4, 8'h75, 8'hea, 8'hc9, 8'h8f}
)
(
    input  [7:0] p_in,
    output [7:0] p_out
);

    wire [7:0] p0, p1, p2, p3, p4, p5, p6, p7;

    assign p0 = p_in[0]? cnst[0] : 8'h00;
    assign p1 = p_in[1]? cnst[1] : 8'h00;
    assign p2 = p_in[2]? cnst[2] : 8'h00;
    assign p3 = p_in[3]? cnst[3] : 8'h00;
    assign p4 = p_in[4]? cnst[4] : 8'h00;
    assign p5 = p_in[5]? cnst[5] : 8'h00;
    assign p6 = p_in[6]? cnst[6] : 8'h00;
    assign p7 = p_in[7]? cnst[7] : 8'h00;

    assign p_out = p0 ^ p1 ^ p2 ^ p3 ^ p4 ^ p5 ^ p6 ^ p7;
    
endmodule 
