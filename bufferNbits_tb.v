`timescale 1ns/1ns

module bufferNbits_tb;
    reg [7:0] in;
    reg en;
    wire [7:0] out;
    // uut
    bufferNbits #(.N(8)) buffer (.out(out),.in(in), .en(en));
    initial begin
        $dumpfile("bufferNbits.vcd");
        $dumpvars(0, bufferNbits_tb);
        {en,in} = 9'b0_11111111;
        #10 {en,in} = 9'b1_11111111;
        #10 {en,in} = 9'b1_11110000;
        #10 {en,in} = 9'b0_11110000;
        #10 {en,in} = 9'b1_00001111;
        $finish;
    end 
endmodule
