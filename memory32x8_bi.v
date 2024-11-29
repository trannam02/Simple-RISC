module memory32x8_bi
(
    input clk, rw, en,
    input [4:0] addr,
    inout [7:0] data
);
reg [7:0] memory [31:0];
reg [7:0] data_out;

assign data = (en & !rw) ? (data_out) : 8'bz;

always @(posedge clk) begin
    if(en)
        if(!rw)
            data_out <= memory[addr];
        else if(rw)
            memory[addr] <= data; 
end
endmodule

