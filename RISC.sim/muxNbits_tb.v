`timescale 1ns/1ns
module muxNbits_tb;
    reg [4:0] in_0, in_1;
    reg sel;
    wire [4:0] out;
    // uut
    muxNbits #(.N(5)) mux5 (.out(out), .in_0(in_0), .in_1(in_1), .sel(sel));
    initial begin
//        $dumpfile("muxNbits.vcd");
//        $dumpvars(0, muxNbits_tb);
        {in_0, in_1, sel} = 11'b00000_11111_0;
        #10 {in_0, in_1, sel} = 11'b00000_11111_1;
        #10 {in_0, in_1, sel} = 11'b00001_11111_0;
        #10 {in_0, in_1, sel} = 11'b00000_00010_1;
        #10 {in_0, in_1, sel} = 11'b00000_00010_1;
        $stop;
    end 
endmodule
