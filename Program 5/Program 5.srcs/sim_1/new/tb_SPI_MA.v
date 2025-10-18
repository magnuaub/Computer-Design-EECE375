//Testbench for Syncrhonouse Sequential PISO
//Made by Magnus Arnfinn Aubell
//Last modified 28-09-20205

`timescale 1ns / 1ps

module tb_SPI_MA;
    reg CLK_in;
    reg RST_N;
    reg [7:0] DATA;
    wire SERIAL_DATA_OUT;
    wire CLK_out;

    SPI_MA spi (
        .CLK_in(CLK_in),
        .RST_N(RST_N),
        .DATA(DATA),
        .SERIAL_DATA_OUT(SERIAL_DATA_OUT),
        .CLK_out(CLK_out)
    );
    
    initial CLK_in = 0;
    always #100 CLK_in = !CLK_in;

    initial begin
        RST_N = 0;
        DATA  = 8'b10101010;  
        #100;               
        RST_N = 1;          

        #5000;
        RST_N = 0;
        #5
        DATA  = 8'b10011101;  
        #5;                  
        RST_N = 1;
        
        #5000;
        RST_N = 0;
        #5
        DATA  = 8'b00100100;  
        #5;                  
        RST_N = 1;          
        
        #10000
        $stop;               
    end

    initial begin
        $monitor("Time=%0t | CLK_in=%b | RST_N=%b | DATA=%b | SERIAL_DATA_OUT=%b", 
                 $time, CLK_in, RST_N, DATA, SERIAL_DATA_OUT);
    end

endmodule
