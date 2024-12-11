`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2024 05:03:29 PM
// Design Name: 
// Module Name: cpu_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module cpu_tb();
    
reg clock;
reg reset;
wire [4:0] address_mux_out;
wire [7:0] mem_in_out;
wire mem_rw;
wire [7:0] accumulator_reg;
wire [4:0] pc;
wire [7:0] IR;
initial begin
    clock = 1'b1;
//    reset = 1'b0;
    forever #5 clock = ~clock;
end;

initial begin
    reset = 1'b1;
    #1 reset = 1'b0;
    #200 $finish;
end;
cpu MY_CPU (
    .clock(clock),
    .reset(reset),
    .simul_address_mux_2_mem(address_mux_out),
    .simul_mem_in_out(mem_in_out),
    .simul_sig_rw_mem(mem_rw),
    .simul_AR_2_alu(accumulator_reg),
    .simul_pc_2_address_mux(pc),
    .simul_IR_out(IR)
);
endmodule
