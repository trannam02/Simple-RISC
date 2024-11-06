module memory32x8_bi(
    input clk, r_en, w_en, en,
    input [4:0] addr,
    input [7:0] data,
    output [7:0] out
);
reg [7:0] memory [31:0];
reg [7:0] data_out;

assign out = en ? data_out : 8'bz;

always @(posedge clk) begin
    if(w_en)
        memory[addr] <= data; 
    else if(r_en)
        data_out <= memory[addr];
    else
        data_out <= 8'bx;
end

endmodule
