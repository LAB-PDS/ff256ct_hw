`include "./verilog_files/ff256_mult/ff256_mult_defines.v"

module ff256_mult_main
    #(               
        parameter  BUS_WIDTH  = 2,
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
    input                   cyc_i,  //Cycle Output
    output [1:0]            status_o
    ); 

// INTERNAL SIGNALS ################################
//Dual Port Ram intefaces:
wire  [BUS_WIDTH-1:0]  mult_adr_i;  //Address In
wire  [DATA_WIDTH-1:0] mult_data_o;  //Data In
wire  [DATA_WIDTH-1:0] mult_data_i;  //Data Out
wire                   mult_we_i;  //Write Enable In
wire  [BE_WIDTH-1:  0] mult_sel_i;  //Select Input array
wire                   mult_stb_i;  //Strobe In
wire                   mult_ack_o;  //Acknowledged Out
wire                   mult_cyc_i;  //Cycle Output

//ff256_multiplier_controller signals:
wire       dct_clock_en;
wire [1:0] state_out;
wire [DATA_WIDTH-1:0] data_o_wire;


// INTERNAL REGS ###################################
reg [DATA_WIDTH-1:0] config_reg;

// INTERNAL LOGIC ##################################

//If the MSB is High, this signal is for the configuration register
assign wb_we_i = (adr_i == `CONFIG_ADDR)? 1'b0: we_i;


assign status_o = state_out;

//Update cofiguration register
always @(posedge clk, negedge reset)
begin
    if(reset == 1'b0)
    begin
        config_reg <= 32'd0;
    end 
    else if((adr_i == `CONFIG_ADDR) && (we_i))
    begin
        config_reg <= data_i;
    end
end

// Define data_o:

assign data_o = (adr_i == `CONFIG_ADDR)? {24'h000000,mult_data_o[7:0]}:
                data_o_wire;
					 
assign mult_adr_i = 2'b00;					

// ##################################################
// INSTANCES
dual_port_ram #(.BUS_WIDTH(2)) dual_port_ram_int
   (
   //Common signal:
   .clk           (clk  ), 
   .reset         (reset), 
   //Port 1 interface:
   .port1_adr_i   (adr_i ), //Address In
   .port1_data_i  (data_i), //Data In
   .port1_data_o  (data_o_wire), //Data Out
   .port1_we_i    (we_i  ), //Write Enable In
   .port1_sel_i   (sel_i ), //Select Input array
   .port1_stb_i   (stb_i ), //Strobe In
   .port1_ack_o   (ack_o ), //Acknowledged Out
   .port1_cyc_i   (cyc_i ), //Cycle Output
   //Port 2 intefaces: Acessed by the multiplier controller
   .port2_adr_i   (mult_adr_i), //Address In
   //.port2_data_i  (), //Data In
   .port2_data_o  (mult_data_i), //Data Out
   //.port2_we_i    (mult_we_i  ), //Write Enable In
   .port2_sel_i   (4'b1111), //Select Input array
   .port2_stb_i   (mult_stb_i ), //Strobe In
   .port2_ack_o   (mult_ack_o ), //Acknowledged Out
   .port2_cyc_i   (mult_cyc_i ), //Cycle Output
   ); 


ff256_mult_multiplier ff256_mult_multiplier_inst(
    .f_in (mult_data_i[7:0]),
    .p_in (mult_data_i[15:8]),
    .p_out(mult_data_o[7:0])
);


endmodule