/*
Adder Acumulator Input Multiplexer x_out = x_in[index]
*/
`include "./verilog_files/ff256_mult_by_const/ff256_mult_by_const_defines.sv"
`include "./verilog_files/ff256_cosine_transfom_sequential/ff256_ct_seq_defines.sv"

module ff256_ct_seq_mult_multiplexer
(
    input  [ 2:0]  selector   [0: 7],
    input  [63:0]  x_in             ,
    output [ 7:0]  x_beta_in  [0: 7]
);

// INTERNAL SIGNALS ################################

// INTERNAL LOGIC ##################################

ff256_ct_seq_mux_64_8 mux_64_8_x_0
(
    .selector (selector[0]),
    .x_in     (x_in),
    .x_out    (x_beta_in[0])
);

ff256_ct_seq_mux_64_8 mux_64_8_x_1
(
    .selector (selector[1]),
    .x_in     (x_in),
    .x_out    (x_beta_in[1])
);


ff256_ct_seq_mux_64_8 mux_64_8_x_2
(
    .selector (selector[2]),
    .x_in     (x_in),
    .x_out    (x_beta_in[2])
);

ff256_ct_seq_mux_64_8 mux_64_8_x_3
(
    .selector (selector[3]),
    .x_in     (x_in),
    .x_out    (x_beta_in[3])
);

ff256_ct_seq_mux_64_8 mux_64_8_x_4
(
    .selector (selector[4]),
    .x_in     (x_in),
    .x_out    (x_beta_in[4])
);

ff256_ct_seq_mux_64_8 mux_64_8_x_5
(
    .selector (selector[5]),
    .x_in     (x_in),
    .x_out    (x_beta_in[5])
);


ff256_ct_seq_mux_64_8 mux_64_8_x_6
(
    .selector (selector[6]),
    .x_in     (x_in),
    .x_out    (x_beta_in[6])
);

ff256_ct_seq_mux_64_8 mux_64_8_x_7
(
    .selector (selector[7]),
    .x_in     (x_in),
    .x_out    (x_beta_in[7])
);


endmodule