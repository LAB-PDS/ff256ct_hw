//=======================================================
//  Title: Multiplier by Constants GF(256) Defines
//=======================================================

`ifndef FF256_MULT_BY_CONST_DEFINES_SV
`define FF256_MULT_BY_CONST_DEFINES_SV


`define CONFIG_ADDR 2'b11

// beta = alpha^17, where alpha is the a primitive elemtent of GF(2^8)
parameter logic [7:0] BETA_1  [0:7] = '{8'h98, 8'h2d, 8'h5a, 8'hb4, 8'h75, 8'hea, 8'hc9, 8'h8f}; // beta^1 = [152, 45, 90, 180, 117, 234, 201, 143],
parameter logic [7:0] BETA_2  [0:7] = '{8'h4e, 8'h9c, 8'h25, 8'h4a, 8'h94, 8'h35, 8'h6a, 8'hd4}; // beta^2 = [78, 156, 37, 74, 148, 53, 106, 212],
parameter logic [7:0] BETA_3  [0:7] = '{8'h0a, 8'h14, 8'h28, 8'h50, 8'ha0, 8'h5d, 8'hba, 8'h69}; // beta^3 = [10, 20, 40, 80, 160, 93, 186, 105],
parameter logic [7:0] BETA_4  [0:7] = '{8'h99, 8'h2f, 8'h5e, 8'hbc, 8'h65, 8'hca, 8'h89, 8'h0f}; // beta^4 = [153, 47, 94, 188, 101, 202, 137, 15],
parameter logic [7:0] BETA_6  [0:7] = '{8'h44, 8'h88, 8'h0d, 8'h1a, 8'h34, 8'h68, 8'hd0, 8'hbd}; // beta^6 = [68, 136, 13, 26, 52, 104, 208, 189],
parameter logic [7:0] BETA_8  [0:7] = '{8'h4f, 8'h9e, 8'h21, 8'h42, 8'h84, 8'h15, 8'h2a, 8'h54}; // beta^8 = [79, 158, 33, 66, 132, 21, 42, 84],
parameter logic [7:0] BETA_9  [0:7] = '{8'h92, 8'h39, 8'h72, 8'he4, 8'hd5, 8'hb7, 8'h73, 8'he6}; // beta^9 = [146, 57, 114, 228, 213, 183, 115, 230],
parameter logic [7:0] BETA_12 [0:7] = '{8'hdd, 8'ha7, 8'h53, 8'ha6, 8'h51, 8'ha2, 8'h59, 8'hb2}; // beta^12 = [221, 167, 83, 166, 81, 162, 89, 178]
    
`endif


