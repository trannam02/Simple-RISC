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
    input clock,
    input reset,
    output [4:0] simul_address_mux_2_mem,
    output [7:0] simul_mem_in_out,
    output simul_sig_rw_mem,
    output [7:0] simul_AR_2_alu,
    output [4:0] simul_pc_2_address_mux,
    output [7:0] simul_IR_out
);

wire [4:0] counter_2_pc;
wire [4:0] pc_2_address_mux;
wire [4:0] address_mux_2_mem;

wire [7:0] mem_in_out;
wire [7:0] alu_2_result_reg;
wire [7:0] IR_out;
wire [7:0] acc_mux_2_AR;
wire [7:0] AR_2_alu;
wire [7:0] result_reg_2_acc_mux;

wire alu_is_zero_2_control;
wire is_zero_from_acc;

wire IR_load;

// control signal wire
wire [2:0] sig_alu_op;
wire sig_ar_load;
wire sig_ar_mux;
wire sig_rw_mem;
wire sig_addr_mux;
wire sig_load;
wire sig_load_ir_1;
wire sig_load_ir_2;

// EX signal wire
wire [2:0] sig_ex_alu_op;
wire sig_ex_ar_load;
wire sig_ex_ar_mux;
wire sig_ex_rw_mem;
wire sig_ex_addr_mux;
wire sig_ex_load;
wire sig_ex_load_ir_1;
wire sig_ex_load_ir_2;

// WB signal wire
wire [2:0] sig_wb_alu_op;
wire sig_wb_ar_load;
wire sig_wb_ar_mux;
wire sig_wb_rw_mem;
wire sig_wb_addr_mux;
wire sig_wb_load;
wire sig_wb_load_ir_1;
wire sig_wb_load_ir_2;

// connect to see output
assign simul_sig_rw_mem = sig_rw_mem;

assign simul_address_mux_2_mem = address_mux_2_mem;
assign simul_mem_in_out = mem_in_out;
assign simul_AR_2_alu = AR_2_alu;
assign simul_pc_2_address_mux = pc_2_address_mux;
assign simul_IR_out = IR_out;

counterNbits COUNTER(                   // COUNTER
    .out(counter_2_pc),
    .clk(clock),
    .rst(reset),
    .load(sig_load),
    .preset(IR_out[4:0])
);

registerNbits_neg #(.N(5)) REG_PC (     // PROGRAM COUNTER
    .out(pc_2_address_mux),
    .clk(clock),
    .rst(reset),
    .load(1'b1),
    .in(counter_2_pc)
);

muxNbits #(.N(5)) MUX_ADDRESS (         // ADDRESS MUX
    .out(address_mux_2_mem),
    .in_0(pc_2_address_mux),
    .in_1(IR_out[4:0]),
    .sel(sig_ex_addr_mux)
);

memory32x8_bi MEM (                     // MEMORY
    .data(mem_in_out),
    .clk(clock),
    .en(1'b1),
    .rw(sig_ex_rw_mem),
    .addr(address_mux_2_mem)
);

ALU ALU1 (                              // ALU
    .result(alu_2_result_reg),
    .is_zero(alu_is_zero_2_control), // dont use
    .inA(mem_in_out),
    .inB(AR_2_alu),
    .opcode(sig_ex_alu_op)
);

registerNbits_neg #(.N(8)) REG_RESULT ( // RESULT REG
    .out(result_reg_2_acc_mux),
    .clk(clock),
    .rst(reset),
    .load(1'b1),
    .in(alu_2_result_reg)
);

muxNbits #(.N(8)) MUX_ACC (             // ACCUMULATOR MUX
    .out(acc_mux_2_AR),
    .in_0(result_reg_2_acc_mux),
    .in_1(mem_in_out),
    .sel(sig_wb_ar_mux)
);

registerNbits #(.N(8)) REG_ACC (        // ACCUMULATOR REG
    .out(AR_2_alu),
    .clk(clock),
    .rst(reset),
    .load(sig_wb_ar_load),
    .in(acc_mux_2_AR)
);

bufferNbits #(.N(8)) BUFFER_MEM (       // BUFFER
    .out(mem_in_out),
    .en(sig_ex_rw_mem),
    .in(AR_2_alu)
);

assign IR_load = sig_ex_load_ir_1 & sig_wb_load_ir_2; // AND gate

registerNbits #(.N(8)) REG_INS (        // INSTRUCTION REG
    .out(IR_out),
    .clk(clock),
    .rst(reset),
    .load(IR_load),
    .in(mem_in_out)
);

registerNbits_neg #(.N(9)) REG_CONTROL_EX ( // CONTROL EXECUTE
    .out({
        sig_ex_alu_op, 
        sig_ex_ar_load, 
        sig_ex_ar_mux,
        sig_ex_rw_mem, 
        sig_ex_addr_mux,
        sig_ex_load_ir_1,
        sig_ex_load_ir_2
    }),
    .clk(clock),
    .rst(reset),
    .load(1'b1),
    .in({
        sig_alu_op,
        sig_ar_load,
        sig_ar_mux,
        sig_rw_mem,
        sig_addr_mux,
        sig_load_ir_1,
        sig_load_ir_2
    })
);

registerNbits_neg #(.N(3)) REG_CONTROL_WB ( // CONTROL WRITEBACK REG
    .out({
        sig_wb_ar_load,
        sig_wb_ar_mux,
        sig_wb_load_ir_2
    }),
    .clk(clock),
    .rst(reset),
    .load(1'b1),
    .in({
        sig_ex_ar_load,
        sig_ex_ar_mux,
        sig_ex_load_ir_2
    })
);

assign is_zero_from_acc = AR_2_alu ? 0 : 1;

Controller CONTROLLER (
    .clk(clock),
	.rst(reset),
	.opcode(IR_out[7:5]), 
	.is_zero(is_zero_from_acc),
        
    .alu_op(sig_alu_op),
    .ar_load(sig_ar_load),
    .ar_mux(sig_ar_mux),
    .rw_mem(sig_rw_mem),
    .addr_mux(sig_addr_mux),
    .load(sig_load),
    .load_ir_1(sig_load_ir_1),
    .load_ir_2(sig_load_ir_2)
);
endmodule

