
`define PWORD 8'b00011101

//implementation of a basic multiplication x.f(x) in field GF(2^8)
module ff256_mult_xfx_mult(f,v);
    input wire [7:0] f;
    output wire [7:0] v;

    wire [7:0] f_shift;
    wire [7:0] f_shift_xor;

    assign f_shift = {f[6:0], 1'b0};
    assign f_shift_xor = f_shift ^ `PWORD;
    assign v = f[7]? f_shift_xor : f_shift;
    
endmodule 