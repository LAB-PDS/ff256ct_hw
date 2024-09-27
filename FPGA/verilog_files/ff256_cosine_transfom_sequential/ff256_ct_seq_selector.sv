/*
Adder Acumulator Input Multiplexer x_out = x_in[index]
*/
`include "./verilog_files/ff256_mult_by_const/ff256_mult_by_const_defines.sv"
`include "./verilog_files/ff256_cosine_transfom_sequential/ff256_ct_seq_defines.sv"

module ff256_ct_seq_selector
#(
    parameter logic [2:0] index [0:7][0:7] =  SEL_CTI
)
(
    input           clk,
    input           reset,
    output  [ 2:0]  selector   [0: 7],
    input   [ 4:0]  state

);

// INTERNAL SIGNALS ################################
reg [ 2:0]  selector_i   [0: 7];
// INTERNAL LOGIC ##################################

assign selector_i[0] = (state == `CT_SEQ_IDLE)? index[0][0]:
                (state == `CT_SEQ_S0  )? index[0][1]:
                (state == `CT_SEQ_S1  )? index[0][2]:
                (state == `CT_SEQ_S2  )? index[0][3]:
                (state == `CT_SEQ_S3  )? index[0][4]:
                (state == `CT_SEQ_S4  )? index[0][5]:
                (state == `CT_SEQ_S5  )? index[0][6]:
                (state == `CT_SEQ_S6  )? index[0][7]:
                index[0][7];

assign selector_i[1] = (state == `CT_SEQ_IDLE)? index[1][0]:
                (state == `CT_SEQ_S0  )? index[1][1]:
                (state == `CT_SEQ_S1  )? index[1][2]:
                (state == `CT_SEQ_S2  )? index[1][3]:
                (state == `CT_SEQ_S3  )? index[1][4]:
                (state == `CT_SEQ_S4  )? index[1][5]:
                (state == `CT_SEQ_S5  )? index[1][6]:
                (state == `CT_SEQ_S6  )? index[1][7]:
                index[0][7];

assign selector_i[2] = (state == `CT_SEQ_IDLE)? index[2][0]:
                (state == `CT_SEQ_S0  )? index[2][1]:
                (state == `CT_SEQ_S1  )? index[2][2]:
                (state == `CT_SEQ_S2  )? index[2][3]:
                (state == `CT_SEQ_S3  )? index[2][4]:
                (state == `CT_SEQ_S4  )? index[2][5]:
                (state == `CT_SEQ_S5  )? index[2][6]:
                (state == `CT_SEQ_S6  )? index[2][7]:
                index[0][7];

assign selector_i[3] = (state == `CT_SEQ_IDLE)? index[3][0]:
                (state == `CT_SEQ_S0  )? index[3][1]:
                (state == `CT_SEQ_S1  )? index[3][2]:
                (state == `CT_SEQ_S2  )? index[3][3]:
                (state == `CT_SEQ_S3  )? index[3][4]:
                (state == `CT_SEQ_S4  )? index[3][5]:
                (state == `CT_SEQ_S5  )? index[3][6]:
                (state == `CT_SEQ_S6  )? index[3][7]:
                index[0][7];

assign selector_i[4] = (state == `CT_SEQ_IDLE)? index[4][0]:
                (state == `CT_SEQ_S0  )? index[4][1]:
                (state == `CT_SEQ_S1  )? index[4][2]:
                (state == `CT_SEQ_S2  )? index[4][3]:
                (state == `CT_SEQ_S3  )? index[4][4]:
                (state == `CT_SEQ_S4  )? index[4][5]:
                (state == `CT_SEQ_S5  )? index[4][6]:
                (state == `CT_SEQ_S6  )? index[4][7]:
                index[0][7];

assign selector_i[5] = (state == `CT_SEQ_IDLE)? index[5][0]:
                (state == `CT_SEQ_S0  )? index[5][1]:
                (state == `CT_SEQ_S1  )? index[5][2]:
                (state == `CT_SEQ_S2  )? index[5][3]:
                (state == `CT_SEQ_S3  )? index[5][4]:
                (state == `CT_SEQ_S4  )? index[5][5]:
                (state == `CT_SEQ_S5  )? index[5][6]:
                (state == `CT_SEQ_S6  )? index[5][7]:
                index[0][7];

assign selector_i[6] = (state == `CT_SEQ_IDLE)? index[6][0]:
                (state == `CT_SEQ_S0  )? index[6][1]:
                (state == `CT_SEQ_S1  )? index[6][2]:
                (state == `CT_SEQ_S2  )? index[6][3]:
                (state == `CT_SEQ_S3  )? index[6][4]:
                (state == `CT_SEQ_S4  )? index[6][5]:
                (state == `CT_SEQ_S5  )? index[6][6]:
                (state == `CT_SEQ_S6  )? index[6][7]:
                index[0][7];

assign selector_i[7] = (state == `CT_SEQ_IDLE)? index[7][0]:
                (state == `CT_SEQ_S0  )? index[7][1]:
                (state == `CT_SEQ_S1  )? index[7][2]:
                (state == `CT_SEQ_S2  )? index[7][3]:
                (state == `CT_SEQ_S3  )? index[7][4]:
                (state == `CT_SEQ_S4  )? index[7][5]:
                (state == `CT_SEQ_S5  )? index[7][6]:
                (state == `CT_SEQ_S6  )? index[7][7]:
                index[0][7];

always @(posedge clk, negedge reset)
begin
    if(reset == 1'b0)
    begin
        selector[0] <= 3'd0;
        selector[1] <= 3'd0;
        selector[2] <= 3'd0;
        selector[3] <= 3'd0;
        selector[4] <= 3'd0;
        selector[5] <= 3'd0;
        selector[6] <= 3'd0;
        selector[7] <= 3'd0;
    end 
    else 
    begin
        selector[0] <= selector_i[0];
        selector[1] <= selector_i[1];
        selector[2] <= selector_i[2];
        selector[3] <= selector_i[3];
        selector[4] <= selector_i[4];
        selector[5] <= selector_i[5];
        selector[6] <= selector_i[6];
        selector[7] <= selector_i[7];
    end
end



endmodule