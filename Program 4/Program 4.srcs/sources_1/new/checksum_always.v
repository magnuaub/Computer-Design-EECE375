//Checksum by Magnus Aubell for Program 4 of
//class Computer Design EECE375 at POSTECH
//Last modified: 2025-09-22
//Makes checksum of 3x3 matrix with rows A, B and C.
//This is done using the always function.

`timescale 1ns / 1ps


module checksum_always(
    input  [2:0] A_in,
    input  [2:0] B_in,
    input  [2:0] C_in,
    output reg [3:0] A_out,
    output reg [3:0] B_out,
    output reg [3:0] C_out,
    output reg [3:0] D_out
    );

    always @(A_in or B_in or C_in) begin
        //"resets" previous values
        A_out = {A_in, 1'b0};
        B_out = {B_in, 1'b0};
        C_out = {C_in, 1'b0};
        D_out = 4'b0000; 
    
        if (A_out[1] ^ A_out[2] ^ A_out[3]) //Calc A0
            A_out[0] = 1'b1;
        if (B_out[1] ^ B_out[2] ^ B_out[3]) //Calc B0
            B_out[0] = 1'b1;
        if (C_out[1] ^ C_out[2] ^ C_out[3]) //Calc C0
            C_out[0] = 1'b1;
            
            
        if (A_out[3] ^ B_out[3] ^ C_out[3]) //Calc D3
            D_out[3] = 1'b1;
        if (A_out[2] ^ B_out[2] ^ C_out[2]) //Calc D2
            D_out[2] = 1'b1;
        if (A_out[1] ^ B_out[1] ^ C_out[1]) //Calc D1
            D_out[1] = 1'b1;
        if (A_out[0] ^ B_out[0] ^ C_out[0]) //Calc D0
            D_out[0] = 1'b1;
    end
endmodule