`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/28/2025 10:31:14 AM
// Design Name: 
// Module Name: CLK_divider
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module CLK_divider(
    input CLK_in,
    input RST_N,
    output reg CLK_out
    );
    
    always @(posedge CLK_in or negedge RST_N) begin
        if (!RST_N) begin
            CLK_out <= 0;
        end else begin
            CLK_out <= !CLK_out;
        end
    end
endmodule
