/******************************* 
    MEMORY 32x8 bidirectional
    - read when rw = 0
    - write when rw = 1
    - sync with clock
*******************************/
module memory32x8_bi
(
    input clk, rw, enable_mem_in,
    input [4:0] addr,
    inout [7:0] data
);
reg [7:0] memory [31:0];
reg [7:0] data_out;

initial begin
$readmemh("D:/DATKLL/test/Simple-RISC/assembler/output.mem", memory);
end;

assign data = enable_mem_in ? 8'bz : data_out;
always @(posedge clk) begin
    if(!rw) begin
        data_out <= memory[addr];
    end else if(rw) begin
        memory[addr] <= data;
    end
end
endmodule