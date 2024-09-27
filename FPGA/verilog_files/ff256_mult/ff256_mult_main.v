`include "./verilog_files/ff256_mult/ff256_mult_defines.v"

module ff256_mult_main
    #(               
        parameter  BUS_WIDTH  = 1,
        parameter  DATA_WIDTH = 32,
        parameter  BE_WIDTH   = 4
    )
    (
    //Common signal:
    input clk, 
    input reset, 
    //Wishbone interface:
    input  [BUS_WIDTH-1:0]  adr_i,  //Address In
    input  [DATA_WIDTH-1:0] data_i, //Data In
    output [DATA_WIDTH-1:0] data_o, //Data Out
    input                   we_i,   //Write Enable In
    input  [BE_WIDTH-1:  0] sel_i,  //Select Input array
    input                   stb_i,  //Strobe In
    output                  ack_o,  //Acknowledged Out
    input                   cyc_i  //Cycle Output
    ); 

// INTERNAL SIGNALS ################################
reg  [ 7:0] data_0_in_reg, data_1_in_reg, data_out_reg;
wire [ 7:0] data_mult_o;


// INTERNAL LOGIC ##################################

//Update cofiguration register
always @(posedge clk, negedge reset)
begin
    if(reset == 1'b0)
    begin
        data_0_in_reg <= 8'd0;
        data_1_in_reg <= 8'd0;
    end 
    else 
    begin
        if((adr_i == 1'b0) && (we_i))
        begin
            if(sel_i[0] ==  1'b1)
            begin
                data_0_in_reg <= data_i[7:0];
            end
            if(sel_i[1] == 1'b1)
            begin
                data_1_in_reg <= data_i[15:8]; 
            end
        end
    end
end

// Define data_o:

assign data_o = (adr_i ==  1'b0)? {8'd0,data_out_reg,data_1_in_reg,data_0_in_reg}:
                32'd0;
					 				
ff256_mult_multiplier ff256_mult_multiplier_inst(
    .f_in (data_0_in_reg),
    .p_in (data_1_in_reg),
    .p_out(data_mult_o)
);


always @(posedge clk, negedge reset)
begin
    if(reset == 1'b0)
    begin
        data_out_reg <= 8'd0;
    end 
    else 
    begin
        data_out_reg <= data_mult_o;
    end
end

endmodule