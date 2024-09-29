# Codes of the paper entitled "Hardware architectures for computing the cosine transforms over the finite ﬁeld $\mathbb{F}_{2^8}$".

Authors:  José R. de Oliveira Neto and Vítor A. Coutinho

Contact information: <joserodrigues.oliveiraneto@ufpe.br> or <vitor.coutinho@ufrpe.br>

## Table of contents
1. [General information](#general_information)
2. [Content](#content)
3. [Usage and Requirements](#requirements)
5. [Acknowledgements](#acknowledgements)


### <a id='general_information'></a> General information:

The primary purpose of this repository is to make available the files needed to reproduce the results depicted in the paper entitled **Hardware architectures for computing the cosine transforms over the finite ﬁeld $\mathbb{F}_{2^8}$**, submitted to the **IET Electronics Letters**. If accepted for publication, the link to the manuscript will be placed here.

### <a id='content'></a> Content:

This project consists of the following folders:

- **FPGA**: *HDL files developed/used in this work*
	- **verilog_files**
		- **RAM:** *Avalon to Wishbone bridge to connect the proposed peripherals to the Hard Processor System (HPS);*
		- **ff256_cosine_transform:** *hdl files related to the parallel-combinational and parallel-pipelined architectures;*
		- **ff256_cosine_transform_sequential:** *hdl files related to the sequential architecture;*
		- **ff256_mult**: *hdl files related to the general multiplier;*
		- **ff256_mult_by_const:** *hdl files related to the multiplier by constants;*
- **HPS-APPS**: *C files developed/used in this work*
	- **INC**: *library used in all projects;*
	- **ff256_cosine_transform**: *C codes used to test the four types of the finite field of characteristic two cosine transforms (FF2CT) for the parallel-combinational and parallel-pipelined architectures;*
	- **ff256_cosine_transform_seq**: *C codes used to test the four types of the FF2CT for the sequential architecture;*
	- **ff256_multiplier:** *C codes used to test the general multiplier;*
	- **ff256_multiplier_by_const:** *C codes used to test the multiplier by constants;*
- **PC**: *Python files developed/used in this work*
	- **ff256_cosine_transform:** *Python codes used to test the four types of the finite field of characteristic two cosine transforms (FF2CT) for the parallel-combinational and parallel-pipelined architectures;*
	- **ff256_mult:** *Python codes used to test the four types of the FF2CT for the sequential architecture;*
	- **ff256_mult_const:** *Python codes used to test the multiplier by constants.*

### <a id='requirements'></a> Usage and Requirements:

This project uses the SystemVerilog hardware description language. We synthesized the project on the Intel/Altera Cyclone V SE 5CSEBA6U23I7 SoC using **Quartus Prime 20.1 Prime Standard Edition**. The 5CSEBA6U23I7 chip is present in the **DE10-Nano** development Board from [Terasic](https://www.terasic.com.tw/en/). The microprocessor in the FPGA SoC serves as a test interface between the computer and the FPGA. For this purpose, we use a Linux distribution available in [DE10-nano Resources](https://www.terasic.com.tw/cgi-bin/page/archive.pl?Language=English&CategoryNo=167&No=1046&PartNo=4#contents), running on the microprocessor. The base project used is also in the [DE10-nano Resources](https://www.terasic.com.tw/cgi-bin/page/archive.pl?Language=English&CategoryNo=167&No=1046&PartNo=4#contents). 

We attached the proposed architectures as memory-mapped peripherals in the [Platform Designer](https://www.intel.com/content/www/us/en/software/programmable/quartus-prime/qts-platform-designer.html) using the `avalon_to_wishbone_bridge.v` file to create a component. After that, we can use this component to define different interfaces with different addresses to test each architecture. 

We also wrote programs in C for the HPS microprocessor to establish communication between the microprocessor and a computer using the board's Ethernet port and communicate with the peripherals. 

We wrote programs in Python for the computer to send the input vectors to SoC FPGA and compare the output computed in the FPGA in a hardware-in-loop environment.

Below are examples of calling the three architectures proposed in the top Entity:

```
//Non-pipelined approach
ff256_cosine_transform_main #(.FF256CT(FF256CT_II)) ff256_cosine_transform_type_2_inst
    (
    //Common signal:
    .clk   (clk), 
    .reset (reset), 
    //Wishbone interface:
    .adr_i (ff256_ct_2_adr_o ), //Address In
    .data_i(ff256_ct_2_data_i), //Data In
    .data_o(ff256_ct_2_data_o), //Data Out
    .we_i  (ff256_ct_2_we_i  ), //Write Enable In
    .sel_i (ff256_ct_2_sel_i ), //Select Input array
    .stb_i (ff256_ct_2_stb_i ), //Strobe In
    .ack_o (ff256_ct_2_ack_o ), //Acknowledged Out
    .cyc_i (ff256_ct_2_cyc_i ) //Cycle Output
    ); 

//Pipelined approach
ff256_cosine_transform_pipelined_main #(.FF256CT(FF256CT_III)) ff256_cosine_transform_pipelined_type_3_inst
    (
    //Common signal:
    .clk   (clk), 
    .reset (reset), 
    //Wishbone interface:
    .adr_i (ff256_ct_3_pipelined_adr_o ), //Address In
    .data_i(ff256_ct_3_pipelined_data_i), //Data In
    .data_o(ff256_ct_3_pipelined_data_o), //Data Out
    .we_i  (ff256_ct_3_pipelined_we_i  ), //Write Enable In
    .sel_i (ff256_ct_3_pipelined_sel_i ), //Select Input array
    .stb_i (ff256_ct_3_pipelined_stb_i ), //Strobe In
    .ack_o (ff256_ct_3_pipelined_ack_o ), //Acknowledged Out
    .cyc_i (ff256_ct_3_pipelined_cyc_i ) //Cycle Output
    ); 

//Sequential approach	
ff256_ct_seq_main  
#(.SEL_CT_X(SEL_CTIV))
ff256_ct_4_seq_main_inst
    (
    //Common signal:
    .clk   (clk), 
    .reset (reset), 
    //Wishbone interface:
    .adr_i (ff256_seq_4_adr_o ), //Address In
    .data_i(ff256_seq_4_data_i), //Data In
    .data_o(ff256_seq_4_data_o), //Data Out
    .we_i  (ff256_seq_4_we_i  ), //Write Enable In
    .sel_i (ff256_seq_4_sel_i ), //Select Input array
    .stb_i (ff256_seq_4_stb_i ), //Strobe In
    .ack_o (ff256_seq_4_ack_o ), //Acknowledged Out
    .cyc_i (ff256_seq_4_cyc_i ) //Cycle Output
    ); 
```
As we can see, the parameter `.FF256CT()` defines which transform will be implemented: `FF256CT_I`, `FF256CT_II`, `FF256CT_III`, or `FF256CT_IV`, for the parallel-combinational and parallel-pipelined architectures. Moreover, the parameter `.SEL_CT_X()` selects which transform will be implemented for the sequential architecture: `SEL_CTI`, `SEL_CTII`, `SEL_CTIII`, or `SEL_CTIV`.

### <a id='acknowledgements'></a>Acknowledgements:

- We thank the Intel FPGA Academic Program for the Quartus Prime licenses. FACEPE partly supported this work under grant APQ-1226-3.04/22 and CNPq under grant 405903/2023-5.

