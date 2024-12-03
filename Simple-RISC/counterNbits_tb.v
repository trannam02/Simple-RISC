`timescale 1ns/1ps

module counterNbits_tb();

reg clk, rst, load;
reg [4:0] preset;
wire [4:0] out;

initial begin
    clk = 1'b0;
    forever #5 clk = !clk;
end

initial begin
    $dumpfile("counterNbits_tb.vcd");
    $dumpvars(0, counterNbits_tb);

    {rst, load, preset} = 7'b0_0_11011;
    #50 {rst, load, preset} = 7'b1_0_11011;
    #30 {rst, load, preset} = 7'b1_1_11011;
    #97 {rst, load, preset} = 7'b0_1_11011;
    #50
    {rst, load, preset} = 7'b0_0_00000;
    #200
    $finish;
end
counterNbits #(.N(5)) opop (.clk(clk), .rst(rst), .load(load), .preset(preset), .out(out));
endmodule
