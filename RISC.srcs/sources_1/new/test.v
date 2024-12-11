`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/11/2024 04:40:50 PM
// Design Name: 
// Module Name: test
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


module test(
input [2:0] opcode,
input clk,
output edge_detected,
output [1:0] signal
    );

reg [2:0] reg0, reg1;
reg [1:0] signal1 = 2'b11;
reg [1:0] signal2 = 2'b00; // default
always @(opcode or clk)
begin
reg0 <= opcode;
reg1 <= reg0;
case(opcode)
    0: signal1 <= 2'b01;
    1: signal1 <= 2'b10;
    default: signal1 <= 2'b11;
endcase

end

assign edge_detected = (reg0 ^ reg1) ? 1'b1 : 1'b0;
assign signal = edge_detected ? signal1 : signal2;

endmodule
