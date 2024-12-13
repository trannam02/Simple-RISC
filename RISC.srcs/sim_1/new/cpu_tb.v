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
wire divided_clock;
reg reset;
wire [4:0] address_mux_out;
wire [7:0] mem_in_out;
wire mem_rw;
wire [7:0] accumulator_reg;
wire [4:0] pc;
wire [7:0] IR;
wire o_sig_load_ir_1;
wire o_sig_load_ir_2;
wire [2:0] o_sig_alu_op;

initial begin
    clock = 1'b1;
//    reset = 1'b0;
    forever #3 clock = ~clock;
end;

initial begin
    reset = 1'b1;
    #50 reset = 1'b1;
    #50 reset = 1'b0;
    #50 reset = 1'b1;
    #97 reset = 1'b0;
    #600 $finish;
end;
cpu MY_CPU (
    .clock_in(clock),
//    .divided_clock(divided_clock),
    .reset(reset)
//    .simul_address_mux_2_mem(address_mux_out),
//    .simul_mem_in_out(mem_in_out),
//    .simul_sig_rw_mem(mem_rw),
//    .simul_AR_2_alu(accumulator_reg),
//    .simul_pc_2_address_mux(pc),
//    .simul_IR_out(IR)
//    .o_sig_load_ir_1(o_sig_load_ir_1),
//    .o_sig_load_ir_2(o_sig_load_ir_2),
//    .o_sig_alu_op(o_sig_alu_op)
);
endmodule
