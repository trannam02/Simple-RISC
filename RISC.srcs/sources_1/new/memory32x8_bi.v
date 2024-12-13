/******************************* 
    MEMORY 32x8 bidirectional
    - read when rw = 0
    - write when rw = 1
    - sync with clock
*******************************/
module memory32x8_bi
(
    input clk, rw, en, rst,
    input [4:0] addr,
    inout [7:0] data
);
reg [7:0] memory [31:0];
reg [7:0] data_out;

initial begin
$readmemh("output.mem", memory);
end

assign data = (en & !rw) ? (data_out) : 8'bz;

always @(posedge clk or posedge rst) begin
    if(en)
        if(rst)
            data_out = 0;
        else if(!rw)
            data_out = memory[addr];
        else if(rw)
            memory[addr] = data; 
end
endmodule