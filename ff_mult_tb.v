`timescale 1ns / 1ps
`include "ff_mult.v"

module tb_ff_mult;
    // Inputs
    reg [7:0] f_in;
    reg [7:0] p_in;

    // Outputs
    wire [7:0] p_out;

    // Instantiate the Unit Under Test (UUT)
    ff_mult uut (
        .f_in(f_in), 
        .p_in(p_in), 
        .p_out(p_out)
    );

    // Variables for reading the test file and writing to log file
    integer data_file, log_file;
    integer scan_file;
    reg [7:0] expected_p_out;
    reg [23:0] test_vector;
    integer pass_count, fail_count, total_tests;
    real pass_percentage, fail_percentage; // Declare percentage variables as real

    initial begin
        // Initialize Inputs
        f_in = 0;
        p_in = 0;

        // Open the test data file
        data_file = $fopen("pre-computed-brute-force.txt", "r");
        if (data_file == 0) begin
            $display("Error opening input file 'pre-computed-brute-force.txt'");
            $finish;
        end

        // Open the log file
        log_file = $fopen("test_results.csv", "w");
        if (log_file == 0) begin
            $display("Error opening log file 'test_results.csv'");
            $finish;
        end

        // Write the header to the log file
        $fwrite(log_file, "f_in,p_in,expected_p_out,p_out,result\n");

        // Initialize counters
        pass_count = 0;
        fail_count = 0;
        total_tests = 0;

        // Read and apply test vectors
        while (!$feof(data_file)) begin
            scan_file = $fscanf(data_file, "%x\n", test_vector);
            f_in = test_vector[23:16];
            p_in = test_vector[15:8];
            expected_p_out = test_vector[7:0];

            #10; // Wait for some time to let the output settle

            // Compare and log the results
            if (p_out === expected_p_out) begin
                $fwrite(log_file, "%h,%h,%h,%h,PASS\n", f_in, p_in, expected_p_out, p_out);
                pass_count = pass_count + 1;
            end else begin
                $fwrite(log_file, "%h,%h,%h,%h,FAIL\n", f_in, p_in, expected_p_out, p_out);
                $display("Error: f_in = %h, p_in = %h, expected p_out = %h, got p_out = %h", 
                         f_in, p_in, expected_p_out, p_out);
                fail_count = fail_count + 1;
            end

            total_tests = total_tests + 1;
        end

        // Calculate percentages as real numbers
        if (total_tests > 0) begin
            pass_percentage = (pass_count * 100.0) / total_tests;
            fail_percentage = (fail_count * 100.0) / total_tests;
        end else begin
            pass_percentage = 0.0;
            fail_percentage = 0.0;
        end

        // Write summary to the log file
        $fwrite(log_file, "\nSummary:\n");
        $fwrite(log_file, "Total Tests,%d\n", total_tests);
        $fwrite(log_file, "Pass,%d,%0.2f%%\n", pass_count, pass_percentage);
        $fwrite(log_file, "Fail,%d,%0.2f%%\n", fail_count, fail_percentage);

        // Close files
        $fclose(data_file);
        $fclose(log_file);
        
        if (fail_count == 0)
            $display("All tests passed.");
        else
            $display("Total errors: %d", fail_count);

        $finish;
    end
endmodule