//=======================================================
//  Title: Dual Port RAM 
//  Description: Dual Port RAM with two slave Wishbone 
//  interfaces
//  OBS: Wait request is not implemented yet!!
//=======================================================

//`include "custom_ram_defines.sv"
module dual_port_ram
    #(               
        parameter  BUS_WIDTH  = 5,
        parameter  DATA_WIDTH = 32,
        parameter  BE_WIDTH   = 4,
        //INTERN PARAMETERS:
        parameter  RAM_DATA_WIDTH = 8, //1 Byte
        parameter  RAM_ROW_LENGTH = 32,//Number of 32 bits words (2^5 = 32)
        parameter  RAM_COL_LENGTH = 4 //Number of bytes per address 32/8
    )
    (
    //Common signal:
    input clk, 
    input reset, 
    //Port 1 interface:
    input  [BUS_WIDTH-1:0]  port1_adr_i,  //Address In
    input  [DATA_WIDTH-1:0] port1_data_i, //Data In
    output [DATA_WIDTH-1:0] port1_data_o, //Data Out
    input                   port1_we_i,   //Write Enable In
    input  [BE_WIDTH-1:  0] port1_sel_i,  //Select Input array
    input                   port1_stb_i,  //Strobe In
    output                  port1_ack_o,  //Acknowledged Out
    input                   port1_cyc_i,  //Cycle Output
    output                  port1_tagn_o, //Cycle tag type Out
    input                   port1_tagn_i, //Cycle tag type In
    //Port 2 intefaces:
    input  [BUS_WIDTH-1:0]  port2_adr_i,  //Address In
    input  [DATA_WIDTH-1:0] port2_data_i, //Data In
    output [DATA_WIDTH-1:0] port2_data_o, //Data Out
    input                   port2_we_i,   //Write Enable In
    input  [BE_WIDTH-1:  0] port2_sel_i,  //Select Input array
    input                   port2_stb_i,  //Strobe In
    output                  port2_ack_o,  //Acknowledged Out
    input                   port2_cyc_i,  //Cycle Output
    output                  port2_tagn_o, //Cycle tag type Out
    input                   port2_tagn_i //Cycle tag type In
    ); 
 
    //Memory
    reg [RAM_DATA_WIDTH-1: 0] 	 ram_memory_r [RAM_ROW_LENGTH-1:0][RAM_COL_LENGTH-1:0];
    integer i;

    //Read Port 1:
    assign  port1_data_o[31:24] = (port1_sel_i[3] == 1'b1)? ram_memory_r[port1_adr_i][3]: 8'h00;
    assign  port1_data_o[23:16] = (port1_sel_i[2] == 1'b1)? ram_memory_r[port1_adr_i][2]: 8'h00;
    assign  port1_data_o[15: 8] = (port1_sel_i[1] == 1'b1)? ram_memory_r[port1_adr_i][1]: 8'h00;
    assign  port1_data_o[ 7: 0] = (port1_sel_i[0] == 1'b1)? ram_memory_r[port1_adr_i][0]: 8'h00;

    //Read Port 2:
    assign  port2_data_o[31:24] = (port2_sel_i[3] == 1'b1)? ram_memory_r[port2_adr_i][3]: 8'h00;
    assign  port2_data_o[23:16] = (port2_sel_i[2] == 1'b1)? ram_memory_r[port2_adr_i][2]: 8'h00;
    assign  port2_data_o[15: 8] = (port2_sel_i[1] == 1'b1)? ram_memory_r[port2_adr_i][1]: 8'h00;
    assign  port2_data_o[ 7: 0] = (port2_sel_i[0] == 1'b1)? ram_memory_r[port2_adr_i][0]: 8'h00;
    //assign  port2_data_o = {ram_memory_r[port2_adr_i][3],ram_memory_r[port2_adr_i][2],ram_memory_r[port2_adr_i][1],ram_memory_r[port2_adr_i][0]};
    
    always @(posedge clk)
    begin
        //Port 1
        if(port1_we_i == 1'b1)
        begin      
            if(port1_sel_i[0] == 1'b1)
            begin
             ram_memory_r[port1_adr_i][0] <= port1_data_i[RAM_DATA_WIDTH-1:0];
            end
            if(port1_sel_i[1] == 1'b1)
            begin
             ram_memory_r[port1_adr_i][1] <= port1_data_i[2*RAM_DATA_WIDTH-1:1*RAM_DATA_WIDTH];
            end
            if(port1_sel_i[2] == 1'b1)
            begin
             ram_memory_r[port1_adr_i][2] <= port1_data_i[3*RAM_DATA_WIDTH-1:2*RAM_DATA_WIDTH];
            end
            if(port1_sel_i[3] == 1'b1)
            begin
             ram_memory_r[port1_adr_i][3] <= port1_data_i[4*RAM_DATA_WIDTH-1:3*RAM_DATA_WIDTH];
            end
        end
        //Port 2
        if(port2_we_i == 1'b1)
        begin      
            if(port2_sel_i[0] == 1'b1)
            begin
             ram_memory_r[port2_adr_i][0] <= port2_data_i[RAM_DATA_WIDTH-1:0];
            end
            if(port2_sel_i[1] == 1'b1)
            begin
             ram_memory_r[port2_adr_i][1] <= port2_data_i[2*RAM_DATA_WIDTH-1:1*RAM_DATA_WIDTH];
            end
            if(port2_sel_i[2] == 1'b1)
            begin
             ram_memory_r[port2_adr_i][2] <= port2_data_i[3*RAM_DATA_WIDTH-1:2*RAM_DATA_WIDTH];
            end
            if(port2_sel_i[3] == 1'b1)
            begin
             ram_memory_r[port2_adr_i][3] <= port2_data_i[4*RAM_DATA_WIDTH-1:3*RAM_DATA_WIDTH];
            end
        end
    end //end always

endmodule