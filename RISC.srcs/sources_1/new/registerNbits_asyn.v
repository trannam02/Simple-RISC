/*******************************
    REGISTER N bits
    - reset sync with posedge rst
    - work with signal in
*******************************/
module registerNbits_asyn
#(
    parameter N = 8
)(
    input [N-1:0] in,
    input clk, rst, load,
    output reg [N-1:0] out
);

always @(posedge rst) begin
    out <= 0;
end

always @(in, load) begin
    if(load && !rst)
        out <= in;
end
endmodule
