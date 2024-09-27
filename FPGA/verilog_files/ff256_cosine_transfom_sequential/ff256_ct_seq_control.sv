/*
Optimized computation of X_out[:] = F256CT[:,:]*x_in[:].
x_in[:] shall be furnished sequentially in 8 clock cycle in the order x0, x1, x2..., x7.
*/
`include "./verilog_files/ff256_mult_by_const/ff256_mult_by_const_defines.sv"
`include "./verilog_files/ff256_cosine_transfom_sequential/ff256_ct_seq_defines.sv"

module ff256_ct_seq_control
(
    input          clk,
    input          rst,
    input          strt_cmpt,
    output [ 4:0]  state_o
);

// INTERNAL SIGNALS ################################

reg  [ 4:0] state, next_state;

// INTERNAL LOGIC ##################################

// Output logic
assign state_o = state;

//#################### SEQUENTIAL LOGIC

    // transition and reset
    always @(posedge clk, negedge rst) begin
        if (rst == 1'b0)
            state <= `CT_SEQ_IDLE;
        else
            state <= next_state;
    end



    // transiction logic
    always @(strt_cmpt,state) begin
        case (state)
            `CT_SEQ_IDLE:
            begin
                if(strt_cmpt)
                begin
                    next_state   <=  `CT_SEQ_S0;
                end
                else
                begin
                    next_state   <=  `CT_SEQ_IDLE;
                end
            end    
            `CT_SEQ_S0:
            begin   
                next_state     <= `CT_SEQ_S1;
            end
            `CT_SEQ_S1:   
            begin   
                next_state     <= `CT_SEQ_S2;
            end
            `CT_SEQ_S2:  
            begin   
                next_state     <= `CT_SEQ_S3;
            end
            `CT_SEQ_S3:
            begin   
                next_state     <= `CT_SEQ_S4;
            end
            `CT_SEQ_S4:  
            begin   
                next_state     <= `CT_SEQ_S5;
            end
            `CT_SEQ_S5:
            begin   
                next_state     <= `CT_SEQ_S6;
            end
            `CT_SEQ_S6:
            begin   
                next_state     <= `CT_SEQ_S7;
            end
            `CT_SEQ_S7:
            begin   
                next_state     <= `CT_SEQ_S8;
            end
            `CT_SEQ_S8:
            begin   
                next_state     <= `CT_SEQ_S9;
            end
            `CT_SEQ_S9:   
            begin   
                next_state     <= `CT_SEQ_DONE;
            end
            `CT_SEQ_DONE:
                if(strt_cmpt)
                begin
                    next_state   <=  `CT_SEQ_DONE;
                end
                else
                begin
                    next_state   <=  `CT_SEQ_IDLE;
                end
            default: 
            begin   
                next_state     <= `CT_SEQ_IDLE;
            end
        endcase
    end

endmodule