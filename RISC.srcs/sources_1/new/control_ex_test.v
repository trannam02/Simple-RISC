`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/14/2024 10:58:52 PM
// Design Name: 
// Module Name: control_ex_test
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


module control_ex_test
#(
    parameter N = 9
)(
    input [N-1:0] in,
    input clk, rst, load,
    output [N-1:0] out
);
reg [N-1:0] i_out = {
3'b111,
1'b0,
1'b0,
1'b0,
1'b0,
1'b1,
1'b1
};
assign out = i_out;
always @(negedge clk) begin
    if(rst)
        i_out <= 0;
    else if(load)
        i_out <= in;
end
endmodule
