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


module cpu_tb;
    reg clock;
    reg reset;
    wire [7:0] IR_out, mem_in_out;
    wire sig_is_jump;
    wire [4:0] address_mux_2_mem;
    wire sig_stop;
    wire [2:0] sig_alu_op;
    wire sig_addr_mux, sig_rw_mem, sig_ar_mux, sig_ar_load, sig_ir_load, stall, sig_ex_ir_load;

    initial begin
        clock = 1'b0;
        reset = 1'b0;
        forever #5 clock = ~clock;  
    end

    // Dừng mô phỏng sau 200 đơn vị thời gian
    initial begin
        #200 $finish;
    end

    // Khởi tạo module CPU
    cpu MY_CPU (
        .clock(clock),
        .reset(reset),
        .address_mux_2_mem(address_mux_2_mem),
        .IR_out(IR_out),
        .sig_is_jump(sig_is_jump),
        .sig_stop(sig_stop),
        .sig_alu_op(sig_alu_op),
        .sig_addr_mux(sig_addr_mux),
        .sig_rw_mem(sig_rw_mem), 
        .sig_ar_mux(sig_ar_mux), 
        .sig_ar_load(sig_ar_load),
        .mem_in_out(mem_in_out),
        .sig_ir_load(sig_ir_load),
        .stall(stall),
        .sig_ex_ir_load(sig_ex_ir_load)
    );
endmodule
