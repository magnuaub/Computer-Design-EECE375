//Clock divider made for Sequential PISO Circuit
//Made by Magnus Arnfinn Aubell
//Last modified 28-09-20205

`timescale 1ns / 1ps

module CLK_divider_tb;

    // Testbench signals
    reg CLK_in;
    reg RST_N;
    wire CLK_out;

    // Instantiate the CLK_divider
    CLK_divider uut (
        .CLK_in(CLK_in),
        .RST_N(RST_N),
        .CLK_out(CLK_out)
    );

    // Generate input clock: 10ns period (100 MHz)
    initial CLK_in = 0;
    always #5 CLK_in = ~CLK_in;

    // Test procedure
    initial begin
        // Initialize reset
        RST_N = 0;
        #20;          // hold reset for 20 ns
        RST_N = 1;    // release reset

        // Run simulation for some time
        #200;

        $stop;        // stop simulation
    end

    // Optional: monitor signals
    initial begin
        $monitor("Time=%0t | CLK_in=%b | RST_N=%b | CLK_out=%b", $time, CLK_in, RST_N, CLK_out);
    end

endmodule
