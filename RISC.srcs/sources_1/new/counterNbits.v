/*******************************
    COUNTER

    - load async
    - reset async
    - work with posedge clock
*******************************/
//module counterNbits
//#(parameter N = 5)(
//    input clk, rst, load,
//    input [N-1:0] preset,
//    output reg [N-1:0] out = 0
//);
///* reg [N-1:0] count = 0; */
//always @(posedge clk, rst, load) begin
//    if(rst)
//        out = 0;
//    else if(load)
//        out = preset;
//    else if(clk)
//        out = out + 1;      
//end

//endmodule

module counterNbits
#(parameter N = 5)(
    input clk, rst, load,
    input [N-1:0] preset,
    output reg [N-1:0] out = 0
);
reg stop = 0;
always@(posedge clk) 
 
  begin
    if(rst) begin   //Set Counter to Zero
      out <= 0;
      stop <= 0;
    end
   else if(stop)
           out <= 5'd25;
    else if(load)    //load the counter with preset
      out <= preset;
    else 
      begin
      if(out >= 5'd25)
        stop <= 1;
      else
        out <= out + 1;
      end
  end
endmodule