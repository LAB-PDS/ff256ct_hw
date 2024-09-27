//=======================================================
//  Title: Sequential cosine transform in GF(256) Defines
//=======================================================

`ifndef FF256_CT_SEQ_DEFINES_V
`define FF256_CT_SEQ_DEFINES_V

    // FSM defines
    `define CT_SEQ_IDLE   5'd0   
    `define CT_SEQ_S0     5'd1
    `define CT_SEQ_S1     5'd2
    `define CT_SEQ_S2     5'd3
    `define CT_SEQ_S3     5'd4
    `define CT_SEQ_S4     5'd5
    `define CT_SEQ_S5     5'd6
    `define CT_SEQ_S6     5'd7
    `define CT_SEQ_S7     5'd8
    `define CT_SEQ_S8     5'd9
    `define CT_SEQ_S9     5'd10
    `define CT_SEQ_DONE   5'd11   

parameter logic [7:0] MULT_ORDER [0:7][0:7] = '{BETA_1 , BETA_2 , BETA_3 , BETA_4, BETA_6 , BETA_8 , BETA_9 , BETA_12};


// COSINE TRANSFORM TYPE 1                                                                         0  1  2  3  4  5  6  7 
parameter logic [2:0] SEL_B1_CTI  [0:7] =  '{3'd2, 3'd6, 3'd0, 3'd4, 3'd3, 3'd7, 3'd1, 3'd5}; // [ 3  6  1 12  4  2  8  9]
parameter logic [2:0] SEL_B2_CTI  [0:7] =  '{3'd5, 3'd2, 3'd1, 3'd6, 3'd7, 3'd0, 3'd3, 3'd4}; // [ 6 12  2  9  8  4  1  3]
parameter logic [2:0] SEL_B3_CTI  [0:7] =  '{3'd0, 3'd7, 3'd5, 3'd3, 3'd6, 3'd2, 3'd4, 3'd1}; // [ 1  2  9  4  6  3 12  8]
parameter logic [2:0] SEL_B4_CTI  [0:7] =  '{3'd4, 3'd5, 3'd3, 3'd2, 3'd0, 3'd1, 3'd7, 3'd6}; // [12  9  4  3  1  8  2  6]
parameter logic [2:0] SEL_B6_CTI  [0:7] =  '{3'd1, 3'd0, 3'd4, 3'd7, 3'd2, 3'd5, 3'd6, 3'd3}; // [ 4  8  6  1  9 12  3  2]
parameter logic [2:0] SEL_B8_CTI  [0:7] =  '{3'd6, 3'd4, 3'd7, 3'd5, 3'd1, 3'd3, 3'd0, 3'd2}; // [ 2  4  3  8 12  6  9  1]
parameter logic [2:0] SEL_B9_CTI  [0:7] =  '{3'd7, 3'd3, 3'd2, 3'd1, 3'd4, 3'd6, 3'd5, 3'd0}; // [ 8  1 12  2  3  9  6  4]
parameter logic [2:0] SEL_B12_CTI [0:7] =  '{3'd3, 3'd1, 3'd6, 3'd0, 3'd5, 3'd4, 3'd2, 3'd7}; // [ 9  3  8  6  2  1  4 12]

parameter logic [2:0] SEL_CTI [0:7][0:7] =  '{SEL_B1_CTI, SEL_B2_CTI, SEL_B3_CTI, SEL_B4_CTI, SEL_B6_CTI, SEL_B8_CTI, SEL_B9_CTI, SEL_B12_CTI};


// COSINE TRANSFORM TYPE 2                                                                  
                                                                                               //  0  1  2  3  4  5  6  7 
parameter logic [2:0] SEL_B1_CTII  [0:7] =  '{3'd5, 3'd1, 3'd7, 3'd3, 3'd4, 3'd0, 3'd6, 3'd2}; // [ 9  3  8  6  2  1  4 12]
parameter logic [2:0] SEL_B2_CTII  [0:7] =  '{3'd2, 3'd5, 3'd6, 3'd1, 3'd0, 3'd7, 3'd4, 3'd3}; // [ 8  1 12  2  3  9  6  4]
parameter logic [2:0] SEL_B3_CTII  [0:7] =  '{3'd7, 3'd0, 3'd2, 3'd4, 3'd1, 3'd5, 3'd3, 3'd6}; // [ 2  4  3  8 12  6  9  1]
parameter logic [2:0] SEL_B4_CTII  [0:7] =  '{3'd3, 3'd2, 3'd4, 3'd5, 3'd7, 3'd6, 3'd0, 3'd1}; // [ 4  8  6  1  9 12  3  2]
parameter logic [2:0] SEL_B6_CTII  [0:7] =  '{3'd6, 3'd7, 3'd3, 3'd0, 3'd5, 3'd2, 3'd1, 3'd4}; // [12  9  4  3  1  8  2  6]
parameter logic [2:0] SEL_B8_CTII  [0:7] =  '{3'd1, 3'd3, 3'd0, 3'd2, 3'd6, 3'd4, 3'd7, 3'd5}; // [ 1  2  9  4  6  3 12  8]
parameter logic [2:0] SEL_B9_CTII  [0:7] =  '{3'd0, 3'd4, 3'd5, 3'd6, 3'd3, 3'd1, 3'd2, 3'd7}; // [ 6 12  2  9  8  4  1  3]
parameter logic [2:0] SEL_B12_CTII [0:7] =  '{3'd4, 3'd6, 3'd1, 3'd7, 3'd2, 3'd3, 3'd5, 3'd0}; // [ 3  6  1 12  4  2  8  9]

parameter logic [2:0] SEL_CTII [0:7][0:7] =  '{SEL_B1_CTII, SEL_B2_CTII, SEL_B3_CTII, SEL_B4_CTII, SEL_B6_CTII, SEL_B8_CTII, SEL_B9_CTII, SEL_B12_CTII};

// COSINE TRANSFORM TYPE 3  

parameter logic [2:0] SEL_B1_CTIII  [0:7] =  '{3'd5, 3'd1, 3'd7, 3'd3, 3'd4, 3'd0, 3'd6, 3'd2}; 
parameter logic [2:0] SEL_B2_CTIII  [0:7] =  '{3'd4, 3'd3, 3'd0, 3'd7, 3'd6, 3'd1, 3'd2, 3'd5}; 
parameter logic [2:0] SEL_B3_CTIII  [0:7] =  '{3'd1, 3'd4, 3'd2, 3'd6, 3'd3, 3'd5, 3'd7, 3'd0}; 
parameter logic [2:0] SEL_B4_CTIII  [0:7] =  '{3'd6, 3'd7, 3'd1, 3'd0, 3'd2, 3'd3, 3'd5, 3'd4}; 
parameter logic [2:0] SEL_B6_CTIII  [0:7] =  '{3'd3, 3'd6, 3'd5, 3'd2, 3'd7, 3'd4, 3'd0, 3'd1}; 
parameter logic [2:0] SEL_B8_CTIII  [0:7] =  '{3'd2, 3'd0, 3'd3, 3'd1, 3'd5, 3'd7, 3'd4, 3'd6}; 
parameter logic [2:0] SEL_B9_CTIII  [0:7] =  '{3'd0, 3'd5, 3'd6, 3'd4, 3'd1, 3'd2, 3'd3, 3'd7}; 
parameter logic [2:0] SEL_B12_CTIII [0:7] =  '{3'd7, 3'd2, 3'd4, 3'd5, 3'd0, 3'd6, 3'd1, 3'd3}; 

parameter logic [2:0] SEL_CTIII [0:7][0:7] =  '{SEL_B1_CTIII, SEL_B2_CTIII, SEL_B3_CTIII, SEL_B4_CTIII, SEL_B6_CTIII, SEL_B8_CTIII, SEL_B9_CTIII, SEL_B12_CTIII};

// COSINE TRANSFORM TYPE 4

parameter logic [2:0] SEL_B1_CTIV  [0:7] =  '{3'd2, 3'd6, 3'd0, 3'd4, 3'd3, 3'd7, 3'd1, 3'd5}; 
parameter logic [2:0] SEL_B2_CTIV  [0:7] =  '{3'd3, 3'd4, 3'd7, 3'd0, 3'd1, 3'd6, 3'd5, 3'd2}; 
parameter logic [2:0] SEL_B3_CTIV  [0:7] =  '{3'd6, 3'd3, 3'd5, 3'd1, 3'd4, 3'd2, 3'd0, 3'd7}; 
parameter logic [2:0] SEL_B4_CTIV  [0:7] =  '{3'd1, 3'd0, 3'd6, 3'd7, 3'd5, 3'd4, 3'd2, 3'd3}; 
parameter logic [2:0] SEL_B6_CTIV  [0:7] =  '{3'd4, 3'd1, 3'd2, 3'd5, 3'd0, 3'd3, 3'd7, 3'd6}; 
parameter logic [2:0] SEL_B8_CTIV  [0:7] =  '{3'd5, 3'd7, 3'd4, 3'd6, 3'd2, 3'd0, 3'd3, 3'd1}; 
parameter logic [2:0] SEL_B9_CTIV  [0:7] =  '{3'd7, 3'd2, 3'd1, 3'd3, 3'd6, 3'd5, 3'd4, 3'd0}; 
parameter logic [2:0] SEL_B12_CTIV [0:7] =  '{3'd0, 3'd5, 3'd3, 3'd2, 3'd7, 3'd1, 3'd6, 3'd4}; 

parameter logic [2:0] SEL_CTIV [0:7][0:7] =  '{SEL_B1_CTIV, SEL_B2_CTIV, SEL_B3_CTIV, SEL_B4_CTIV, SEL_B6_CTIV, SEL_B8_CTIV, SEL_B9_CTIV, SEL_B12_CTIV};

`endif