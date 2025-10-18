//FSM counter with 10 states and reset function
//Made by Magnus Arnfinn Aubell
//Last modified 28-09-20205
//Note: Assumes CLK_in 5Hz in order to get CLK_out at 10Hz

`timescale 1ns / 1ps

module FSM(
    input RST_N,
    input CLK_in,
    input CLK_out,
    output reg [3:0] state
    );
    
     always @(posedge CLK_in or negedge RST_N) begin
        if (!RST_N) begin
            state <= 4'b0;
        end 
        else if (CLK_out) begin
            if (state != 4'b1001) begin
                state <= state + 1;
            end
        end
     end

endmodule
