`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2024 05:03:29 PM
// Design Name: 
// Module Name: cpu_tb
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


module cpu_tb(

    );
reg clock;

initial begin
    clock = 1'b1;
end;

initial begin
    forever #5 clock = ~clock;  
end;

initial begin
    #100 $finish;
end;
cpu MY_CPU (.clock(clock));
endmodule
