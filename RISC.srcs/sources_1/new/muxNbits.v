/*******************************
    MUTIFLEXER N bits
*******************************/
module muxNbits
#(parameter N=5)(
    input [N-1:0] in_0, in_1,
    input sel,
    output [N-1:0] out
);
assign out = sel ? in_1 : in_0;
endmodule
