// Serial Peripheral Interface Module
// Made by Magnus Arnfinn Aubell
// Last modified 17-10-2025
// SPI slave structure based on description from following source:
// [1] Wikipedia contributors. Serial peripheral interface. https://en.wikipedia.org/wiki/Serial_Peripheral_Interface, 2025. Accessed: 2025-10-17.
// Note: CPOL = CPHA = 0 when compared to standard SPI designs. Option to change not added, but possible by modifying pos-/negedge

`timescale 1ms / 1ps

module SPI_tb(
    );
    reg clk;
    reg reset_n, miso;
    wire sclk, ss_n, mosi;
    wire [15:0] data;
    reg [31:0] dummy_memory_in;
    reg [15:0] dummy_memory_data;
    
    initial begin
        miso = 0;
        dummy_memory_in = 0;
        dummy_memory_data = 16'h5714;
        clk = 0;
        forever #10 clk = ~clk; //50Hz
    end
    
    SPI spi( // UUT
        .CLK_IN(clk),
        .RESET_N(reset_n),
        .MISO(miso),
        .SCLK(sclk),
        .SS_N(ss_n),
        .MOSI(mosi),
        .DATA(data)
    );
    
    
    // Dummy memory begin
    always @(posedge sclk) begin // Sample on posedge
        if (~ss_n & dummy_memory_in[31:24] != 8'h03) begin
                dummy_memory_in <= {dummy_memory_in[30:0], mosi};
        end
    end
    
    always @(negedge sclk) begin // Send on negedge
        if (dummy_memory_in == {8'h03, 24'h857140} & ~ss_n) begin
            miso <= dummy_memory_data[15];
            dummy_memory_data <= dummy_memory_data << 1;
        end
    end
    //Dummy flash memory end
    
    initial begin
        //checks normal function
        reset_n = 0;
        #40
        reset_n = 1;
    end
endmodule
