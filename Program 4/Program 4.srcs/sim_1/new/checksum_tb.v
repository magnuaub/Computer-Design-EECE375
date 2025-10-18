// Checksum testbench by Magnus Aubell for Program 4 of class Computer Design EECE375
// Date created: 2025-09-22
// Complete testsum  testbench, testing every possible combination.
//Use of display command was based on code given in:
//[1] Sunggu Lee, Program 4: Verilog Coding for Combinational Logic, EECE375 Computer Design, course handout, 2025.

`timescale 1ns / 1ps

module checksum_tb;

    localparam T = 2;

    reg [2:0] A_in, B_in, C_in;
    wire [3:0] A_out, B_out, C_out, D_out;
    integer i; //Iteration variable

    
    checksum_always Checksum ( //Add/Remove "_always" after "checksum" to switch between 
        .A_in(A_in),
        .B_in(B_in),
        .C_in(C_in),
        .A_out(A_out),
        .B_out(B_out),
        .C_out(C_out),
        .D_out(D_out)
    );

    initial begin
    $display(" Time&i|    In    |   Out   ");
    $display("_______________________________________________");

    for (i = 0; i < 512; i = i + 1) begin 
        A_in = i[2:0];
        B_in = i[5:3];
        C_in = i[8:6];
        
        // Wait for time step
        #T;
        
        // Display the current time and values
        $display("    %0t|A_in %b |A_out %b", $time, A_in, A_out);
        $display("%d|B_in %b |B_out %b", i, B_in, B_out);
        $display("           |C_in %b |C_out %b", C_in, C_out);
        $display("           |         |D_out %b", D_out);
        $display("-----------------------------------------------");
    end 

    $finish;
end

endmodule