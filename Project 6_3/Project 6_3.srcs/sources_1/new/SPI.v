// Serial Peripheral Interface Module
// Made by Magnus Arnfinn Aubell
// Last modified 17-10-2025
// SPI master structure based on description from following source:
// [1] Wikipedia contributors. Serial peripheral interface. https://en.wikipedia.org/wiki/Serial_Peripheral_Interface, 2025. Accessed: 2025-10-17.
// Note: CPOL = CPHA = 0 when compared to standard SPI. Option to change not added, but possible by modifying pos-/negedge
`timescale 1ns / 1ps

module SPI(
    input CLK_IN,
    input RESET_N,
    input MISO,
    output reg SCLK,
    output SS_N,
    output reg MOSI,
    output [15:0] DATA
    );
    
    reg [32:0] Output;
    wire sent; //Bool used to stop sending when done
    reg [17:0] data_temp; //Temp data used to store data, bit to skip first negedge sample and end of shifting bit 1
    
    assign SS_N = ~RESET_N;
    assign sent = (Output == 33'h100000000);
    assign DATA = data_temp[15:0];
    
    initial begin
        data_temp = 0;
        SCLK = 0;
        Output = {8'h03, 24'h857140, 1'b1}; //read command + address + bit for skipping first sample negedge + bit indicating end
        data_temp = 18'b1; // bit indicating end
        MOSI = 0;
    end
    
    always @(posedge CLK_IN) begin //CLK halfer
        if(RESET_N) begin
            SCLK <= ~SCLK;
        end else begin //Idle state
            SCLK <= 0;
        end
    end
    
    always @(negedge SCLK) begin // Sends on negedge
        if(RESET_N & !sent) begin
                MOSI <= Output[32]; 
                Output <= Output << 1;
        end
    end
    
    always @(posedge SCLK) begin //Sample on posedge
        if(RESET_N & data_temp[17] != 1 & sent) begin
            data_temp <= {data_temp[16:0], MISO};
        end
    end
endmodule
