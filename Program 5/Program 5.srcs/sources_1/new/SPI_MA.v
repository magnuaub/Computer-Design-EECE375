//Syncrhonouse Sequential PISO
//Made by Magnus Arnfinn Aubell
//Last modified 28-09-2025
//Case statement based on lecture given by Lee Sunggu:
//[2] Sunggu Lee. Computer design – eece375 lecture. In-person lecture, 2025. Lecture given 29 September 2025.
//Note: Assumes CLK_in 5Hz in order to get CLK_out at 10Hz

`timescale 1ns / 1ps


module SPI_MA(
    input CLK_in,
    input RST_N,
    input [7:0] DATA,
    output reg SERIAL_DATA_OUT,
    output CLK_out
    );

    
    wire [3:0] state;
    CLK_divider clk_divider (
        .CLK_in(CLK_in),
        .RST_N(RST_N),
        .CLK_out(CLK_out)
    );
    
    FSM fsm (
    .CLK_in(CLK_in),
    .CLK_out(CLK_out),
    .RST_N(RST_N),
    .state(state)
    );
    
    always @(posedge CLK_in or negedge RST_N) begin
        if (!RST_N) begin
        SERIAL_DATA_OUT <= 0;
    end else if (CLK_out) begin   // safe: acts as enable, not a clock
        case(state)
            4'b0000 : SERIAL_DATA_OUT <= 0;
            4'b0001 : SERIAL_DATA_OUT <= DATA[7];
            4'b0010 : SERIAL_DATA_OUT <= DATA[6];
            4'b0011 : SERIAL_DATA_OUT <= DATA[5];
            4'b0100 : SERIAL_DATA_OUT <= DATA[4];
            4'b0101 : SERIAL_DATA_OUT <= DATA[3];
            4'b0110 : SERIAL_DATA_OUT <= DATA[2];
            4'b0111 : SERIAL_DATA_OUT <= DATA[1];
            4'b1000 : SERIAL_DATA_OUT <= DATA[0];
            default : SERIAL_DATA_OUT <= 0;
        endcase
    end
end

endmodule
