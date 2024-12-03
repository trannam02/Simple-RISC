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
