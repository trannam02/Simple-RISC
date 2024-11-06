module registerNbits
#(
    parameter N = 8
)(
    input [N-1:0] in,
    input clk, rst, load,
    output reg [N-1:0] out
);

always @(posedge clk) begin
    if(rst)
        out <= 0;
    else if(load)
        out <= in;
end
endmodule
