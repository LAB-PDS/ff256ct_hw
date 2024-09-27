/*
Multiplexer 64 bits IN -> 8 bits OUT
*/

module ff256_ct_seq_mux_64_8
(
    input  [ 2:0]  selector,
    input  [63:0]  x_in,
    output [ 7:0]  x_out
);

// INTERNAL SIGNALS ################################

// INTERNAL LOGIC ##################################

// Output logic

//Output mux logic
assign x_out         = (selector == 3'b000)? x_in[ 7: 0]:
                       (selector == 3'b001)? x_in[15: 8]:
                       (selector == 3'b010)? x_in[23:16]:
                       (selector == 3'b011)? x_in[31:24]:
                       (selector == 3'b100)? x_in[39:32]:
                       (selector == 3'b101)? x_in[47:40]:
                       (selector == 3'b110)? x_in[55:48]:
                       (selector == 3'b111)? x_in[63:56]: 8'hxx;

endmodule