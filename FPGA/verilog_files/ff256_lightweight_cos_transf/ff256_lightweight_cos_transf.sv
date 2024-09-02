/*
Optimized computation of X_out[:] = F256CT[:,:]*x_in[:].
x_in[:] shall be furnished sequentially in 8 clock cycle in the order x0, x1, x2..., x7.
*/
`include "./verilog_files/ff256_mult_by_const/ff256_mult_by_const_defines.sv"
`include "./verilog_files/ff256_lightweight_cos_transf/ff256_lightweight_cos_transf_defines.sv"

module ff256_lightweight_cos_transf
#(
    parameter logic [7:0] cnst [0:7] =  '{8'h98, 8'h2d, 8'h5a, 8'hb4, 8'h75, 8'hea, 8'hc9, 8'h8f}
)
(
    input  [7:0]  x_in,
    input clk,
    input strt_cmpt,
    input rst,
    output [63:0]  x_out,
    output output_ready
);

// INTERNAL SIGNALS ################################
reg [7:0] x_0_o, x_1_o, x_2_o, x_3_o, x_4_o, x_5_o, x_6_o, x_7_o; //output vector

// INTERNAL LOGIC ##################################

assign x_out[ 7: 0] = (output_ready?) x_0_o : 8'hz;
assign x_out[15: 8] = (output_ready?) x_1_o : 8'hz;
assign x_out[23:16] = (output_ready?) x_2_o : 8'hz;
assign x_out[31:24] = (output_ready?) x_3_o : 8'hz;
assign x_out[39:32] = (output_ready?) x_4_o : 8'hz;
assign x_out[47:40] = (output_ready?) x_5_o : 8'hz;
assign x_out[55:48] = (output_ready?) x_6_o : 8'hz;
assign x_out[63:56] = (output_ready?) x_7_o : 8'hz;

wire [7:0] beta_1_data_o, beta_2_data_o, beta_3_data_o, beta_4_data_o, beta_6_data_o, beta_8_data_o, beta_9_data_o, beta_12_data_o;

reg [3:0] state, next_state;

// ##################################################
// INSTANCES

ff256_mult_by_const_multiplier #(.cnst(BETA_1)) beta_1_inst(
    .p_in (x_in),
    .p_out(beta_1_data_o)
);

 ff256_mult_by_const_multiplier #(.cnst(BETA_2)) beta_2_inst(
     .p_in (x_in),
     .p_out(beta_2_data_o)
 );

 ff256_mult_by_const_multiplier #(.cnst(BETA_3)) beta_3_inst(
     .p_in (x_in),
     .p_out(beta_3_data_o)
 );

 ff256_mult_by_const_multiplier #(.cnst(BETA_4)) beta_4_inst(
     .p_in (x_in),
     .p_out(beta_4_data_o)
 );

 ff256_mult_by_const_multiplier #(.cnst(BETA_6)) beta_6_inst(
     .p_in (x_in),
     .p_out(beta_6_data_o)
 );

 ff256_mult_by_const_multiplier #(.cnst(BETA_8)) beta_8_inst(
     .p_in (x_in),
     .p_out(beta_8_data_o)
 );

 ff256_mult_by_const_multiplier #(.cnst(BETA_9)) beta_9_inst(
     .p_in (x_in),
     .p_out(beta_9_data_o)
 );
 
  ff256_mult_by_const_multiplier #(.cnst(BETA_12)) beta_12_inst(
     .p_in (x_in),
     .p_out(beta_12_data_o)
 );

//#################### SEQUENTIAL LOGIC

    // transition and reset
    always @(posedge clk or posedge rst) begin
        if (rst)
            state <= `IDLE;
        else
            state <= next_state;
    end

    // transiction logic
    always @(*) begin
        case (state)
            `IDLE: next_state = strt_cmpt ? `S0 : `IDLE;
            `S0: next_state = `S1;
            `S1: next_state = `S2;
            `S2: next_state = `S3;
            `S3: next_state = `S4;
            `S4: next_state = `S5;
            `S5: next_state = `S6;
            `S6: next_state = `S7;
            `S7: next_state = `DONE;
            `DONE: next_state = strt_cmpt ? `DONE : `IDLE;
            default: next_state = `IDLE;
        endcase
    end

    // computing and output logic
    always @(state) begin
        case (state)
            `IDLE: 
                output_ready = 1'b0;
                x_0_o = 8'd0;
                x_0_1 = 8'd0;
                x_0_2 = 8'd0;
                x_0_3 = 8'd0;
                x_0_4 = 8'd0;
                x_0_5 = 8'd0;
                x_0_6 = 8'd0;
                x_0_7 = 8'd0;
            `S0:
                output_ready = 1'b0;
                x_0_o = x_0_o ^ beta_3_data_o;
                x_1_o = x_1_o ^ beta_6_data_o;
                x_2_o = x_2_o ^ beta_1_data_o;
                x_3_o = x_3_o ^ beta_12_data_o;
                x_4_o = x_4_o ^ beta_4_data_o;
                x_5_o = x_5_o ^ beta_2_data_o;
                x_6_o = x_6_o ^ beta_8_data_o;
                x_7_o = x_7_o ^ beta_9_data_o;
            `S1:
                output_ready = 1'b0;
                x_0_o = x_0_o ^ beta_6_data_o;
                x_1_o = x_1_o ^ beta_12_data_o;
                x_2_o = x_2_o ^ beta_2_data_o;
                x_3_o = x_3_o ^ beta_9_data_o;
                x_4_o = x_4_o ^ beta_8_data_o;
                x_5_o = x_5_o ^ beta_4_data_o;
                x_6_o = x_6_o ^ beta_1_data_o;
                x_7_o = x_7_o ^ beta_3_data_o;
            `S2: 
                output_ready = 1'b0;
                x_0_o = x_0_o ^ beta_1_data_o;
                x_1_o = x_1_o ^ beta_2_data_o;
                x_2_o = x_2_o ^ beta_9_data_o;
                x_3_o = x_3_o ^ beta_4_data_o;
                x_4_o = x_4_o ^ beta_6_data_o;
                x_5_o = x_5_o ^ beta_3_data_o;
                x_6_o = x_6_o ^ beta_12_data_o;
                x_7_o = x_7_o ^ beta_8_data_o;
            `S3:
                output_ready = 1'b0;
                x_0_o = x_0_o ^ beta_12_data_o;
                x_1_o = x_1_o ^ beta_9_data_o;
                x_2_o = x_2_o ^ beta_4_data_o;
                x_3_o = x_3_o ^ beta_3_data_o;
                x_4_o = x_4_o ^ beta_1_data_o;
                x_5_o = x_5_o ^ beta_8_data_o;
                x_6_o = x_6_o ^ beta_2_data_o;
                x_7_o = x_7_o ^ beta_6_data_o;
            `S4:
                output_ready = 1'b0;
                x_0_o = x_0_o ^ beta_4_data_o;
                x_1_o = x_1_o ^ beta_8_data_o;
                x_2_o = x_2_o ^ beta_6_data_o;
                x_3_o = x_3_o ^ beta_1_data_o;
                x_4_o = x_4_o ^ beta_9_data_o;
                x_5_o = x_5_o ^ beta_12_data_o;
                x_6_o = x_6_o ^ beta_3_data_o;
                x_7_o = x_7_o ^ beta_2_data_o;            
            `S5: next_state = `S6;
                output_ready = 1'b0;
                x_0_o = x_0_o ^ beta_2_data_o;
                x_1_o = x_1_o ^ beta_4_data_o;
                x_2_o = x_2_o ^ beta_3_data_o;
                x_3_o = x_3_o ^ beta_8_data_o;
                x_4_o = x_4_o ^ beta_12_data_o;
                x_5_o = x_5_o ^ beta_6_data_o;
                x_6_o = x_6_o ^ beta_9_data_o;
                x_7_o = x_7_o ^ beta_1_data_o;     
            `S6: 
                output_ready = 1'b0;
                x_0_o = x_0_o ^ beta_8_data_o;
                x_1_o = x_1_o ^ beta_1_data_o;
                x_2_o = x_2_o ^ beta_12_data_o;
                x_3_o = x_3_o ^ beta_2_data_o;
                x_4_o = x_4_o ^ beta_3_data_o;
                x_5_o = x_5_o ^ beta_9_data_o;
                x_6_o = x_6_o ^ beta_6_data_o;
                x_7_o = x_7_o ^ beta_4_data_o;   
            `S7: 
                output_ready = 1'b0;
                x_0_o = x_0_o ^ beta_9_data_o;
                x_1_o = x_1_o ^ beta_3_data_o;
                x_2_o = x_2_o ^ beta_8_data_o;
                x_3_o = x_3_o ^ beta_6_data_o;
                x_4_o = x_4_o ^ beta_2_data_o;
                x_5_o = x_5_o ^ beta_1_data_o;
                x_6_o = x_6_o ^ beta_4_data_o;
                x_7_o = x_7_o ^ beta_12_data_o;
            `DONE: output_ready = 1'b1;
            default: next_state = `IDLE;
        endcase
    end

endmodule