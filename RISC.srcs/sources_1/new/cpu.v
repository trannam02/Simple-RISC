`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2024 05:06:09 PM
// Design Name: 
// Module Name: cpu
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


module cpu(
    input clock
);

wire [4:0] counter_2_pc, pc_2_address_mux, AR_2_alu;
wire [4:0] address_mux_2_mem, result_reg_2_acc_mux;

wire [7:0] mem_in_out, alu_2_result_reg, IR_out, acc_mux_2_AR;

wire alu_is_zero_2_control;

// control signal wire
wire sig_stop, sig_addr_mux, sig_enable_mem, sig_rw_mem, sig_ar_mux, sig_ar_load, sig_is_jump;
wire [2:0] sig_alu_op;

// EX signal wire
wire sig_ex_addr_mux, sig_ex_rw_mem;
wire [1:0] sig_ex_alu_op;
wire sig_ex_stop, sig_ex_enable_mem, sig_ex_ar_mux, sig_ex_ar_load, sig_ex_is_jump;

// WB signal wire
wire sig_wb_ar_mux,sig_wb_ar_load;


counterNbits COUNTER(
    .out(counter_2_pc),
    .clk(clock),
    .rst(reset),
    .load(sig_is_jump),
    .preset(IR_out[4:0])
);

registerNbits_neg #(.N(5)) REG_PC ( // PROGRAM COUNTER
    .out(pc_2_address_mux),
    .clk(clock),
    .rst(reset),
    .load(1'b1),
    .in(counter_2_pc)
);

muxNbits #(.N(5)) MUX_ADDRESS ( // ADDRESS MUX
    .out(address_mux_2_mem),
    .in_0(pc_2_address_mux),
    .in_1(IR_out[4:0]),
    .sel(sig_addr_mux)
);

memory32x8_bi MEM ( // MEMORY
    .data(mem_in_out),
    .clk(clock),
    .en(sig_enable_mem),
    .rw(sig_rw_mem),
    .addr(address_mux_2_mem)
);

ALU ALU1 (
    .result(alu_2_result_reg),
    .is_zero(alu_is_zero_2_control),
    .inA(mem_in_out),
    .inB(AR_2_alu),
    .opcode(sig_alu_op)
);

registerNbits_neg #(.N(8)) REG_RESULT ( // RESULT REG // have not modified yet
    .out(result_reg_2_acc_mux),
    .clk(clock),
    .rst(reset),
    .load(1'b1),
    .in(alu_2_result_reg)
);

muxNbits #(.N(8)) MUX_ACC ( // ADDRESS MUX
    .out(acc_mux_2_AR),
    .in_0(result_reg_2_acc_mux),
    .in_1(mem_in_out),
    .sel(sig_ar_mux)
);

registerNbits #(.N(8)) REG_ACC ( // ACCUMULATOR REG
    .out(AR_2_alu),
    .clk(clock),
    .rst(reset),
    .load(sig_ar_load),
    .in(acc_mux_2_AR)
);

bufferNbits #(.N(8)) BUFFER_MEM (
    .out(mem_in_out),
    .en(sig_rw_mem),
    .in(AR_2_alu)
);

registerNbits #(.N(8)) REG_INS ( // ACCUMULATOR REG
    .out(IR_out),
    .clk(clock),
    .rst(reset),
    .load(1'b1), // instead of sig_is_jump
    .in(mem_in_out)
);

registerNbits_neg #(.N(6)) REG_CONTROL_EX ( // RESULT REG // have not modified yet
    .out({sig_ex_addr_mux, sig_ex_rw_mem, sig_ex_ar_mux, sig_ex_ar_load, sig_ex_alu_op}),
    .clk(clock),
    .rst(reset),
    .load(1'b1),
    .in({sig_addr_mux,sig_rw_mem,sig_ar_mux, sig_ar_load, sig_alu_op})
);

registerNbits_neg #(.N(6)) REG_CONTROL_WB ( // RESULT REG // have not modified yet
    .out({sig_wb_ar_mux, sig_wb_ar_load}),
    .clk(clock),
    .rst(reset),
    .load(1'b1),
    .in({sig_ex_ar_mux, sig_ex_ar_load})
);

Controller CONTROLLER (
	.stop(sig_stop),
	.alu_op(sig_alu_op),
	.addr_mux(sig_addr_mux),
	.enable_mem(sig_enable_mem),
	.rw_mem(sig_rw_mem),	
	.ar_mux(sig_ar_mux),
	.ar_load(sig_ar_load),
	.is_jump(sig_is_jump),
    .clk(clock),
	.rst(reset),
	.opcode(IR_out[7:5]), 
	.is_zero(alu_is_zero_2_control)
);
endmodule

