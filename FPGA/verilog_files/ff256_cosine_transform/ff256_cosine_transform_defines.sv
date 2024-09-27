//=======================================================
//  Title:  GF(256) Cosine Transform Defines
//=======================================================

`ifndef FF256_COSINE_TRANSFORM_DEFINES_SV
`define FF256_COSINE_TRANSFORM_DEFINES_SV

//Values of BETA_X come from:
`include "./verilog_files/ff256_mult_by_const/ff256_mult_by_const_defines.sv"


// The FF256 Cosine Transform of Type I (FF256CT-I) matrix as function of beta, where
// beta = alpha^17, and alpha is a primitive elemtent of GF(2^8)
// [ 3  6  1 12  4  2  8  9]
// [ 6 12  2  9  8  4  1  3]
// [ 1  2  9  4  6  3 12  8]
// [12  9  4  3  1  8  2  6]
// [ 4  8  6  1  9 12  3  2]
// [ 2  4  3  8 12  6  9  1]
// [ 8  1 12  2  3  9  6  4]
// [ 9  3  8  6  2  1  4 12]

parameter logic [7:0] FF256CT_I_ROW_0 [0:7][0:7] = '{BETA_3 , BETA_6 , BETA_1 , BETA_12, BETA_4 , BETA_2 , BETA_8 , BETA_9 };
parameter logic [7:0] FF256CT_I_ROW_1 [0:7][0:7] = '{BETA_6 , BETA_12, BETA_2 , BETA_9 , BETA_8 , BETA_4 , BETA_1 , BETA_3 };
parameter logic [7:0] FF256CT_I_ROW_2 [0:7][0:7] = '{BETA_1 , BETA_2 , BETA_9 , BETA_4 , BETA_6 , BETA_3 , BETA_12, BETA_8 };
parameter logic [7:0] FF256CT_I_ROW_3 [0:7][0:7] = '{BETA_12, BETA_9 , BETA_4 , BETA_3 , BETA_1 , BETA_8 , BETA_2 , BETA_6 };
parameter logic [7:0] FF256CT_I_ROW_4 [0:7][0:7] = '{BETA_4 , BETA_8 , BETA_6 , BETA_1 , BETA_9 , BETA_12, BETA_3 , BETA_2 };
parameter logic [7:0] FF256CT_I_ROW_5 [0:7][0:7] = '{BETA_2 , BETA_4 , BETA_3 , BETA_8 , BETA_12, BETA_6 , BETA_9 , BETA_1 };
parameter logic [7:0] FF256CT_I_ROW_6 [0:7][0:7] = '{BETA_8 , BETA_1 , BETA_12, BETA_2 , BETA_3 , BETA_9 , BETA_6 , BETA_4 };
parameter logic [7:0] FF256CT_I_ROW_7 [0:7][0:7] = '{BETA_9 , BETA_3 , BETA_8 , BETA_6 , BETA_2 , BETA_1 , BETA_4 , BETA_12};


// ffct2_gen:

// [ 9  3  8  6  2  1  4 12]
// [ 8  1 12  2  3  9  6  4]
// [ 2  4  3  8 12  6  9  1]
// [ 4  8  6  1  9 12  3  2]
// [12  9  4  3  1  8  2  6]
// [ 1  2  9  4  6  3 12  8]
// [ 6 12  2  9  8  4  1  3]
// [ 3  6  1 12  4  2  8  9]

parameter logic [7:0] FF256CT_II_ROW_0 [0:7][0:7] = '{BETA_9 , BETA_3 , BETA_8 , BETA_6 , BETA_2 , BETA_1 , BETA_4 , BETA_12};
parameter logic [7:0] FF256CT_II_ROW_1 [0:7][0:7] = '{BETA_8 , BETA_1 , BETA_12, BETA_2 , BETA_3 , BETA_9 , BETA_6 , BETA_4 };
parameter logic [7:0] FF256CT_II_ROW_2 [0:7][0:7] = '{BETA_2 , BETA_4 , BETA_3 , BETA_8 , BETA_12, BETA_6 , BETA_9 , BETA_1 };
parameter logic [7:0] FF256CT_II_ROW_3 [0:7][0:7] = '{BETA_4 , BETA_8 , BETA_6 , BETA_1 , BETA_9 , BETA_12, BETA_3 , BETA_2 };
parameter logic [7:0] FF256CT_II_ROW_4 [0:7][0:7] = '{BETA_12, BETA_9 , BETA_4 , BETA_3 , BETA_1 , BETA_8 , BETA_2 , BETA_6 };
parameter logic [7:0] FF256CT_II_ROW_5 [0:7][0:7] = '{BETA_1 , BETA_2 , BETA_9 , BETA_4 , BETA_6 , BETA_3 , BETA_12, BETA_8 };
parameter logic [7:0] FF256CT_II_ROW_6 [0:7][0:7] = '{BETA_6 , BETA_12, BETA_2 , BETA_9 , BETA_8 , BETA_4 , BETA_1 , BETA_3 };
parameter logic [7:0] FF256CT_II_ROW_7 [0:7][0:7] = '{BETA_3 , BETA_6 , BETA_1 , BETA_12, BETA_4 , BETA_2 , BETA_8 , BETA_9 };


// ffct3_gen:

// [ 9  8  2  4 12  1  6  3]
// [ 3  1  4  8  9  2 12  6]
// [ 8 12  3  6  4  9  2  1]
// [ 6  2  8  1  3  4  9 12]
// [ 2  3 12  9  1  6  8  4]
// [ 1  9  6 12  8  3  4  2]
// [ 4  6  9  3  2 12  1  8]
// [12  4  1  2  6  8  3  9]

parameter logic [7:0] FF256CT_III_ROW_0 [0:7][0:7] = '{BETA_9 , BETA_8 , BETA_2 , BETA_4 , BETA_12, BETA_1 , BETA_6 , BETA_3 };
parameter logic [7:0] FF256CT_III_ROW_1 [0:7][0:7] = '{BETA_3 , BETA_1 , BETA_4 , BETA_8 , BETA_9 , BETA_2 , BETA_12, BETA_6 };
parameter logic [7:0] FF256CT_III_ROW_2 [0:7][0:7] = '{BETA_8 , BETA_12, BETA_3 , BETA_6 , BETA_4 , BETA_9 , BETA_2 , BETA_1 };
parameter logic [7:0] FF256CT_III_ROW_3 [0:7][0:7] = '{BETA_6 , BETA_2 , BETA_8 , BETA_1 , BETA_3 , BETA_4 , BETA_9 , BETA_12};
parameter logic [7:0] FF256CT_III_ROW_4 [0:7][0:7] = '{BETA_2 , BETA_3 , BETA_12, BETA_9 , BETA_1 , BETA_6 , BETA_8 , BETA_4 };
parameter logic [7:0] FF256CT_III_ROW_5 [0:7][0:7] = '{BETA_1 , BETA_9 , BETA_6 , BETA_12, BETA_8 , BETA_3 , BETA_4 , BETA_2 };
parameter logic [7:0] FF256CT_III_ROW_6 [0:7][0:7] = '{BETA_4 , BETA_6 , BETA_9 , BETA_3 , BETA_2 , BETA_12, BETA_1 , BETA_8 };
parameter logic [7:0] FF256CT_III_ROW_7 [0:7][0:7] = '{BETA_12, BETA_4 , BETA_1 , BETA_2 , BETA_6 , BETA_8 , BETA_3 , BETA_9 };


// ffct4_gen:

// [12  4  1  2  6  8  3  9]
// [ 4  6  9  3  2 12  1  8]
// [ 1  9  6 12  8  3  4  2]
// [ 2  3 12  9  1  6  8  4]
// [ 6  2  8  1  3  4  9 12]
// [ 8 12  3  6  4  9  2  1]
// [ 3  1  4  8  9  2 12  6]
// [ 9  8  2  4 12  1  6  3]

parameter logic [7:0] FF256CT_IV_ROW_0 [0:7][0:7] = '{BETA_12, BETA_4 , BETA_1 , BETA_2 , BETA_6 , BETA_8 , BETA_3 , BETA_9 };
parameter logic [7:0] FF256CT_IV_ROW_1 [0:7][0:7] = '{BETA_4 , BETA_6 , BETA_9 , BETA_3 , BETA_2 , BETA_12, BETA_1 , BETA_8 };
parameter logic [7:0] FF256CT_IV_ROW_2 [0:7][0:7] = '{BETA_1 , BETA_9 , BETA_6 , BETA_12, BETA_8 , BETA_3 , BETA_4 , BETA_2 };
parameter logic [7:0] FF256CT_IV_ROW_3 [0:7][0:7] = '{BETA_2 , BETA_3 , BETA_12, BETA_9 , BETA_1 , BETA_6 , BETA_8 , BETA_4 };
parameter logic [7:0] FF256CT_IV_ROW_4 [0:7][0:7] = '{BETA_6 , BETA_2 , BETA_8 , BETA_1 , BETA_3 , BETA_4 , BETA_9 , BETA_12};
parameter logic [7:0] FF256CT_IV_ROW_5 [0:7][0:7] = '{BETA_8 , BETA_12, BETA_3 , BETA_6 , BETA_4 , BETA_9 , BETA_2 , BETA_1 };
parameter logic [7:0] FF256CT_IV_ROW_6 [0:7][0:7] = '{BETA_3 , BETA_1 , BETA_4 , BETA_8 , BETA_9 , BETA_2 , BETA_12, BETA_6 };
parameter logic [7:0] FF256CT_IV_ROW_7 [0:7][0:7] = '{BETA_9 , BETA_8 , BETA_2 , BETA_4 , BETA_12, BETA_1 , BETA_6 , BETA_3 };


//Compacting the rows of the matrices in a 3D array:

parameter logic [7:0] FF256CT_I [0:7][0:7][0:7]   = '{FF256CT_I_ROW_0,   FF256CT_I_ROW_1,   FF256CT_I_ROW_2,   FF256CT_I_ROW_3,   FF256CT_I_ROW_4,   FF256CT_I_ROW_5,   FF256CT_I_ROW_6,   FF256CT_I_ROW_7};
parameter logic [7:0] FF256CT_II [0:7][0:7][0:7]  = '{FF256CT_II_ROW_0,  FF256CT_II_ROW_1,  FF256CT_II_ROW_2,  FF256CT_II_ROW_3,  FF256CT_II_ROW_4,  FF256CT_II_ROW_5,  FF256CT_II_ROW_6,  FF256CT_II_ROW_7};
parameter logic [7:0] FF256CT_III [0:7][0:7][0:7] = '{FF256CT_III_ROW_0, FF256CT_III_ROW_1, FF256CT_III_ROW_2, FF256CT_III_ROW_3, FF256CT_III_ROW_4, FF256CT_III_ROW_5, FF256CT_III_ROW_6, FF256CT_III_ROW_7};
parameter logic [7:0] FF256CT_IV [0:7][0:7][0:7]  = '{FF256CT_IV_ROW_0,  FF256CT_IV_ROW_1,  FF256CT_IV_ROW_2,  FF256CT_IV_ROW_3,  FF256CT_IV_ROW_4,  FF256CT_IV_ROW_5,  FF256CT_IV_ROW_6,  FF256CT_IV_ROW_7};

`endif
