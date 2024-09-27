`include "./verilog_files/ff256_cosine_transform/ff256_cosine_transform_defines.sv"

module ff256_cosine_transform_main
    #(      
        parameter logic [7:0] FF256CT [0:7][0:7][0:7] = FF256CT_I,
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
    input                   cyc_i,  //Cycle Output
    output [1:0]            status_o
    ); 

// INTERNAL SIGNALS ################################
wire [63:0] x_in; //it concatenates the two registers to form the x_in 
wire [ 7:0] ff256ct_0_o, ff256ct_1_o, ff256ct_2_o, ff256ct_3_o, ff256ct_4_o, ff256ct_5_o, ff256ct_6_o, ff256ct_7_o; //eache one of the X_out values

// INTERNAL REGS ###################################
reg [DATA_WIDTH-1:0] data_i_reg [1:0];
reg [63:0] x_out;

// INTERNAL LOGIC ##################################

//Update registers
always @(posedge clk, negedge reset)
begin
    if(reset == 1'b0)
    begin
        data_i_reg[0] <= 32'd0;
        data_i_reg[1] <= 32'd0;
    end 
    else 
    begin
        if((adr_i == 1'b0) && (we_i))
        begin
            data_i_reg[0] <= data_i;
        end
        if((adr_i == 1'b1) && (we_i))
        begin
            data_i_reg[1] <= data_i;
        end
    end
end


//Update registers
always @(posedge clk, negedge reset)
begin
    if(reset == 1'b0)
    begin
        x_out <= 64'd0;
    end 
    else 
    begin
        x_out[ 7: 0] <= ff256ct_0_o;
        x_out[15: 8] <= ff256ct_1_o;
        x_out[23:16] <= ff256ct_2_o;
        x_out[31:24] <= ff256ct_3_o;
        x_out[39:32] <= ff256ct_4_o;
        x_out[47:40] <= ff256ct_5_o;
        x_out[55:48] <= ff256ct_6_o;
        x_out[63:56] <= ff256ct_7_o;
    end
end

// Define x_in:

assign x_in = {data_i_reg[1],data_i_reg[0]};

// Define data_o:

//assign data_o = (adr_i == 1'b0)? {ff256ct_3_o, ff256ct_2_o, ff256ct_1_o, ff256ct_0_o}:
//                                 {ff256ct_7_o, ff256ct_6_o, ff256ct_5_o, ff256ct_4_o};
assign data_o = (adr_i == 1'b0)? x_out[31: 0]:
                                 x_out[63:32];
				

// ##################################################
// INSTANCES


ff256_cosine_transform_direct #(.betas(FF256CT[0])) ff256ct_0_inst(//#(.betas(FF256CT_I_ROW_0)) ff256ct_0_inst(
    .x_in (x_in),
    .x_out(ff256ct_0_o)
);

ff256_cosine_transform_direct #(.betas(FF256CT[1])) ff256ct_1_inst(//#(.betas(FF256CT_I_ROW_1)) ff256ct_1_inst(
    .x_in (x_in),
    .x_out(ff256ct_1_o)
);

ff256_cosine_transform_direct #(.betas(FF256CT[2])) ff256ct_2_inst(//#(.betas(FF256CT_I_ROW_2)) ff256ct_2_inst(
    .x_in (x_in),
    .x_out(ff256ct_2_o)
);

ff256_cosine_transform_direct #(.betas(FF256CT[3])) ff256ct_3_inst(//#(.betas(FF256CT_I_ROW_3)) ff256ct_3_inst(
    .x_in (x_in),
    .x_out(ff256ct_3_o)
);

ff256_cosine_transform_direct #(.betas(FF256CT[4])) ff256ct_4_inst(//#(.betas(FF256CT_I_ROW_4)) ff256ct_4_inst(
    .x_in (x_in),
    .x_out(ff256ct_4_o)
);

ff256_cosine_transform_direct #(.betas(FF256CT[5])) ff256ct_5_inst(//#(.betas(FF256CT_I_ROW_5)) ff256ct_5_inst(
    .x_in (x_in),
    .x_out(ff256ct_5_o)
);

ff256_cosine_transform_direct #(.betas(FF256CT[6])) ff256ct_6_inst(//#(.betas(FF256CT_I_ROW_6)) ff256ct_6_inst(
    .x_in (x_in),
    .x_out(ff256ct_6_o)
);

ff256_cosine_transform_direct #(.betas(FF256CT[7])) ff256ct_7_inst(//#(.betas(FF256CT_I_ROW_7)) ff256ct_7_inst(
    .x_in (x_in),
    .x_out(ff256ct_7_o)
);

endmodule