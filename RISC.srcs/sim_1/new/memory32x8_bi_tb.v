`timescale 1ns/1ps

module memory32x8_bi_tb();
reg clk, rw, en;
reg [4:0] addr;
reg [7:0] input_data; // driven value
wire [7:0] data; /* inout data */

initial begin
clk = 1'b1;
forever #5 clk = ~clk;
end

assign data = rw ? input_data : 8'bz;

/* assign data = input_data; */
/* assign vision = data; */

initial begin
//    $dumpfile("memory32x8_bi_tb.vcd");
//    $dumpvars(0, memory32x8_bi_tb);
    {en, rw, addr, input_data} = 15'b1_0_00000_00000000;
    #18 {en, rw, addr, input_data} = 15'b1_1_00001_00000010;
    #6 {en, rw, addr, input_data} = 15'b1_0_00001_00000000;
    #3 {en, rw, addr, input_data} = 15'b1_0_00001_00000000;
    #20 {en, rw, addr, input_data} = 15'b1_0_00010_00000000;
    #20 {en, rw, addr, input_data} = 15'b1_0_00001_00000000;
    #20 {en, rw, addr, input_data} = 15'b1_0_11111_00000000;
    #10
    $finish;
end
memory32x8_bi mem(.data(data), .clk(clk), .en(en), .rw(rw), .addr(addr));
endmodule
