/******************************* 
    MEMORY 32x8 bidirectional
    - read when rw = 0
    - write when rw = 1
    - sync with clock
*******************************/
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
        else
            data_out <= 8'bz;
end
always @(negedge clk) begin
    if(en)
        if(rw)
            memory[addr] <= data; 
end
endmodule

/*******************************
    MUTIFLEXER N bits
*******************************/
module muxNbits
#(parameter N=5)(
    input [N-1:0] in_0, in_1,
    input sel,
    output [N-1:0] out
);
assign out = sel ? in_1 : in_0;
endmodule

/*******************************
    REGISTER N bits
    - reset sync with posedge clock
    - work with posedge clock
*******************************/
module registerNbits
#(
    parameter N = 8
)(
    input [N-1:0] in,
    input clk, rst, load,
    output reg [N-1:0] out
);

always @(posedge clk) begin
    if(rst)
        out <= 0;
    else if(load)
        out <= in;
end
endmodule
/*******************************
    COUNTER

    - load async
    - reset async
    - work with posedge clock
*******************************/
module counterNbits
#(parameter N = 5)(
    input clk, rst, load,
    input [N-1:0] preset,
    output reg [N-1:0] out = 0
);
/* reg [N-1:0] count = 0; */
always @(posedge clk) begin
    if(!load && !rst) begin
        out <= out + 1;
    end
end
always @(load, rst) begin
    if(rst)
        out = 0;
    else if(load)
        out = preset;
end

endmodule

/*******************************
    ALU 
*******************************/
/* TODO */
/*******************************
    CONTROL
*******************************/
/* TODO */
