module bufferNbits
#(parameter N=8)(
    input [N-1:0] in,
    input en,
    output [N-1:0] out
);
assign out = en ? in : 'bz;
endmodule
