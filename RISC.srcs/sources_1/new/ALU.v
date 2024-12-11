/*******************************
    ALU 
    
    Instruction code
    - HLT: 000
    - SKZ: 001
    - ADD: 010
    - AND: 011
    - XOR: 100
    - LAD: 101
    - STO: 110
    - JMP: 111
*******************************/

module ALU (
    input [7:0] inA,           
    input [7:0] inB,           
    input [2:0] opcode,        
    output reg [7:0] result = 0,   
    output reg is_zero        
);

localparam HLT = 3'b000;
localparam SKZ = 3'b001;
localparam ADD = 3'b010;
localparam AND_OP = 3'b011;
localparam XOR_OP = 3'b100;
localparam LDA = 3'b101;
localparam STO = 3'b110;
localparam JMP = 3'b111;

always @(*) begin
    case (opcode)
        HLT: begin
            result = 8'b00000000;
        end
        SKZ: begin
            if (inB == 8'b00000000) begin // nam edit result -> inB
                is_zero = 1'b1;
            end else begin
                is_zero = 1'b0;
            end
        end
        ADD: begin
            result = inA + inB;
        end
        AND_OP: begin
            result = inA & inB;
        end
        XOR_OP: begin
            result = inA ^ inB;
        end
        LDA: begin
            result = inB;
        end
        STO: begin
            result = inA;
        end
        JMP: begin
            result = inA;
        end
        default: begin
            result = 8'b00000000;
        end
    endcase

    is_zero = (inB == 8'b00000000) ? 1'b1 : 1'b0; // nam edit result -> inB
end

endmodule
