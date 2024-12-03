module cpu(
    input clock,
    input reset,
);
wire [4:0] counter_2_pc, pc_2_mem, AR_2_alu;
wire [4:0] address_mux_2_mem;
wire [7:0] mem_in_out;
wire [7:0] alu_2_result_reg;

counterNbits COUNTER(
    .out(counter_2_pc),
    .clk(clock),
    .rst(reset),
    .load(),
    .preset()
);

registerNbits_neg #(.N(8)) PC (
    .out(pc_2_mem),
    .clk(clock),
    .rst(reset),
    .load(),
    .in(counter_2_pc)
);

muxNbits #(.N(5)) ADDRESS_MUX (
    .out(address_mux_2_mem),
    .in_0(),
    .in_1(),
    .sel()
);

memory32x8_bi MEM (
    .data(mem_in_out),
    .clk(clock),
    .en(),
    .rw(),
    .addr(address_mux_2_mem)
);

ALU ALU1 (
    .result(alu_2_result_reg),
    .is_zero(),
    .inA(mem_in_out),
    .inB(AR_2_alu),
    .opcode()
);

registerNbits_neg #(.N(8)) RG (
    .out(pc_2_mem),
    .clk(clock),
    .rst(reset),
    .load(),
    .in(counter_2_pc)
);
endmodule
