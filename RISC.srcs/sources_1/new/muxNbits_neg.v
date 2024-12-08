/*******************************
    MUTIFLEXER N bits
*******************************/
module muxNbits_neg
#(parameter N=5)(
    input [N-1:0] in_0, in_1,
    input sel, clk, rst,
    output [N-1:0] out
);
always @(negedge clk) begin
    if(sel)
        out = in_1;
    else
        out = in_0;
end

endmodule
