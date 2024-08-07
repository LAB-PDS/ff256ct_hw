`include "xfx_mult.v"

module xfx_mult_tb;
    // Sinais para conectar ao DUT (Device Under Test)
    reg [7:0] f;    // Entrada
    wire [7:0] v;   // Saída

    // Instancia o módulo xfx_mult
    xfx_mult uut (
        .f(f),
        .v(v)
    );

    // Procedimento de inicialização
    initial begin
        // Dumpfile para visualização com GTKWave
        $dumpfile("xfx_mult_tb.vcd");
        $dumpvars(0, xfx_mult_tb);

        // Teste 1: f = 8'b00000000
        f = 8'b00000000;
        #10;
        $display("f = %b, v = %b", f, v);

        // Teste 2: f = 8'b00000001
        f = 8'b00000001;
        #10;
        $display("f = %b, v = %b", f, v);

        // Teste 3: f = 8'b10000000
        f = 8'b10101110;
        #10;
        $display("f = %b, v = %b", f, v);

        // Teste 4: f = 8'b11111111
        f = 8'b10001110;
        #10;
        $display("f = %b, v = %b", f, v);

        // Teste 5: f = 8'b01010101
        f = 8'b01010101;
        #10;
        $display("f = %b, v = %b", f, v);

        // Termina a simulação
        $finish;
    end
endmodule  