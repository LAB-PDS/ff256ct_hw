
`include "xfx_mult.v"

/*
Implementation of multiplication f_in * p_in = p_out in GF(2^8)
No pipeline version.
*/
module ff_mult(f_in, p_in, p_out);
    input wire [7:0] f_in;
    input wire [7:0] p_in;
    output wire [7:0] p_out;

    wire [7:0] xfx, x2fx, x3fx, x4fx, x5fx, x6fx, x7fx;
    wire [7:0] p0, p1, p2, p3, p4, p5, p6, p7;

    xfx_mult m0 (f_in, xfx);
    xfx_mult m1 (xfx, x2fx);
    xfx_mult m2 (x2fx, x3fx);
    xfx_mult m3 (x3fx, x4fx);
    xfx_mult m4 (x4fx, x5fx);
    xfx_mult m5 (x5fx, x6fx);
    xfx_mult m6 (x6fx, x7fx);

    assign p0 = p_in[0]? f_in : 8'd0;
    assign p1 = p_in[1]? xfx : 8'd0;
    assign p2 = p_in[2]? x2fx : 8'd0;
    assign p3 = p_in[3]? x3fx : 8'd0;
    assign p4 = p_in[4]? x4fx : 8'd0;
    assign p5 = p_in[5]? x5fx : 8'd0;
    assign p6 = p_in[6]? x6fx : 8'd0;
    assign p7 = p_in[7]? x7fx : 8'd0;

    assign p_out = p0 ^ p1 ^ p2 ^ p3 ^ p4 ^ p5 ^ p6 ^ p7;
    
endmodule 
