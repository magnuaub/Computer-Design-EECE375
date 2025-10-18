//Checksum by Magnus Aubell for Program 4 of class
//Computer Design EECE375 at POSTECH
//Last modified: 2025-09-22
//makes checksum of 3x3 matrix with rows A, B and C.
//This is done using simple assigns.

`timescale 1ns / 1ps

module checksum(
    input  [2:0] A_in,
    input  [2:0] B_in,
    input  [2:0] C_in,
    output [3:0] A_out,
    output [3:0] B_out,
    output [3:0] C_out,
    output [3:0] D_out
);

    assign A_out[3:1] = A_in;
    assign B_out[3:1] = B_in;
    assign C_out[3:1] = C_in;

    assign A_out[0] = A_out[1] ^ A_out[2] ^ A_out[3];
    assign B_out[0] = B_out[1] ^ B_out[2] ^ B_out[3];
    assign C_out[0] = C_out[1] ^ C_out[2] ^ C_out[3];

    assign D_out = A_out ^ B_out ^ C_out;

endmodule