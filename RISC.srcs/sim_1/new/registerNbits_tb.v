`timescale 1ns/1ps

module registerNbits_tb();

reg clk, rst, load;
reg [7:0] in;
wire [7:0] out;

initial begin
    clk = 1'b1;
    forever #5  clk = ~clk;
end

initial begin
//    $dumpfile("registerNbits.vcd");
//    $dumpvars(0, registerNbits_tb);
    {rst,load, in} = 10'b0_0_00000000;
    #20 {rst,load, in} = 10'b0_0_00000000;
    #20 {rst,load, in} = 10'b0_1_00000100;
    #20 {rst,load, in} = 10'b0_0_00000000;
    #17 {rst,load, in} = 10'b1_0_00000000;
    #20 {rst,load, in} = 10'b0_1_00000010;
     
    #10
    $finish;
end
registerNbits #(.N(8)) reg8 (.out(out), .clk(clk), .rst(rst), .load(load), .in(in));
endmodule
