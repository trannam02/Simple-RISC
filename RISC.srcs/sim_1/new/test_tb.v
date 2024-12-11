`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/11/2024 04:49:32 PM
// Design Name: 
// Module Name: test_tb
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


module test_tb();
wire out;
wire [1:0] signal;
reg clk;
reg [2:0] a;
initial begin
    clk = 1;
    forever #5 clk = ~clk;
end;

initial begin
    
    #5 a = 3'b000;
    #5 a = 3'b000; // clk = 1
    #5 a = 3'b000;
    #5 a = 3'b100; // clk = 1
    #5 a = 3'b100;
    #5 a = 3'b100;
    #5 a = 3'b100;
    #5 a = 3'b100;
    #5 a = 3'b100;
    #5 a = 3'b000;
        #5 a = 3'b000; // clk = 1
        #5 a = 3'b000;
        #5 a = 3'b100; // clk = 1
        #5 a = 3'b100;
        #5 a = 3'b100;
        #5 a = 3'b100;
        #5 a = 3'b100;
        #5 a = 3'b100;
    #50 $finish;
end;

test hehe(.edge_detected(out), .clk(clk), .opcode(a), .signal(signal));
endmodule
