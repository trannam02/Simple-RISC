`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2024 05:23:42 PM
// Design Name: 
// Module Name: registerNbits_neg
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
//    REGISTER N bits
//    - reset sync with posedge clock
//    - work with negedge clock
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module registerNbits_neg
#(
    parameter N = 8
)(
    input [N-1:0] in,
    input clk, rst, load,
    output reg [N-1:0] out
);

always @(negedge clk) begin
    if(rst)
        out = 0;
    else if(load)
        out = in;
end
endmodule
