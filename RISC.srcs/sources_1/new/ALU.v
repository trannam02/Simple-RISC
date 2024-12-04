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
    input [7:0] inA,           // toan hang tu mem
    input [7:0] inB,           // toan hang tu acc
    input [2:0] opcode,        // opcode tu control
    output reg [7:0] result,   // output
    output reg is_zero         // bit kiem tra ket qua alu = 0
);

// Dinh nghia ca lenh
localparam ADD = 3'b011;
localparam AND = 3'b010;
localparam XOR = 3'b100;

always @(*) begin
    case (opcode)
        ADD: begin
            // Cong inA va inB, luu ket qua vao result
            result = inA + inB;
            is_zero = (result == 8'b00000000) ? 1'b1 : 1'b0;
        end
        AND: begin
            // and inA va inB
            result = inA & inB;
            is_zero = (result == 8'b00000000) ? 1'b1 : 1'b0;
        end
        XOR: begin
            // xor inA va inB
            result = inA ^ inB;
            is_zero = (result == 8'b00000000) ? 1'b1 : 1'b0;
        end
        default: begin
        // khong lam gi neu lenh khong can dung alu
        // is_zero and result se dc giu nguyen gia tri trc do
        end
    endcase
end

endmodule
