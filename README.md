# Codes of the paper entitled "Hardware architectures for computing the cosine transforms over the finite ﬁeld $\mathbb{F}_{2^8}$".

Authors:  José R. de Oliveira Neto and Vítor A. Coutinho

Contact information: <joserodrigues.oliveiraneto@ufpe.br> or <vitor.coutinho@ufrpe.br >

## Table of contents
1. [General information](#general_information)
2. [Content](#content)
3. [Requirements](#requirements)
5. [Acknowledgements](#acknowledgements)


### <a id='general_information'></a> General information:

 The primary purpose of this project is to reproduce the results depicted in the papers entitled **Hardware architectures for computing the cosine transforms over the finite ﬁeld $\mathbb{F}_{2^8}$**, submitted to the **IET Electronics Letters**. If accepted for publication, the link to the manuscript will be placed here.

### <a id='content'></a> Content:

This project consists of the following folders:

- **FPGA**: *HDL files developed/used in this work*
	- **verilog_files**
		- **RAM:** *Avalon to Wishbone bridge to connect the proposed peripherals to the Hard Processor System (HPS);*
		- **ff256_cosine_transform:** *hdl files related to the parallel-combinational and parallel-pipelined architectures;*
		- **ff256_cosine_transform_sequential:** *hdl files related to the sequential architecture;*
		- **ff256_mult**: *hdl files related to the general multiplier;*
		- **ff256_mult_by_const:**  *hdl files related to the general multiplier;*
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

This project uses the SystemVerilog hardware description language. We synthesized the project on the Intel/Altera Cyclone V SE 5CSEBA6U23I7 SoC using **Quartus Prime 20.1 Prime Standard Edition**. The 5CSEBA6U23I7 chip is present in the **DE10-Nano** development Board from [Terasic](https://www.terasic.com.tw/en/). The microprocessor in the FPGA SoC serves as a test interface between the computer and the FPGA. For this purpose, we use a Linux distribution available in [DE10-nano Resources](https://www.terasic.com.tw/cgi-bin/page/archive.pl?Language=English&CategoryNo=167&No=1046&PartNo=4#contents), running on the microprocessor. The base project used is also in the [DE10-nano Resources](https://www.terasic.com.tw/cgi-bin/page/archive.pl?Language=English&CategoryNo=167&No=1046&PartNo=4#contents). We also wrote programs in the C language to establish communication between the microprocessor and a computer using the Ethernet port of the board. 
We wrote programs in the **Python** language for the testbench to send the input vectors to FGPA and compare the output computed in the FPGA in a hardware-in-loop environment.
### <a id='acknowledgements'></a>Acknowledgements:

- We thank the Intel FPGA Academic Program for the Quartus Prime licenses. FACEPE partly supported this work under grant APQ-1226-3.04/22 and CNPq under grant 405903/2023-5.
