module ALU (
    input [7:0] inA,           // Toán h?ng ??u vào A (8-bit)
    input [7:0] inB,           // Toán h?ng ??u vào B (8-bit)
    input [2:0] opcode,        // Mã l?nh ?i?u khi?n (3-bit)
    output reg [7:0] result,   // K?t qu? ??u ra (8-bit)
    output reg is_zero         // C? ki?m tra n?u k?t qu? b?ng 0
);

// ??nh ngh?a các mã l?nh
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
            // D?ng ho?t ??ng ch??ng trình
            result = 8'b00000000;
        end
        SKZ: begin
            // B? qua l?nh ti?p theo n?u result b?ng 0
            if (result == 8'b00000000) begin
                is_zero = 1'b1;
            end else begin
                is_zero = 1'b0;
            end
        end
        ADD: begin
            // C?ng inA và inB, l?u k?t qu? vào result
            result = inA + inB;
        end
        AND_OP: begin
            // Th?c hi?n AND gi?a inA và inB
            result = inA & inB;
        end
        XOR_OP: begin
            // Th?c hi?n XOR gi?a inA và inB
            result = inA ^ inB;
        end
        LDA: begin
            // ??c giá tr? t? ??a ch? trong l?nh và ??a vào Accumulator
            result = inB;  // Gi? ??nh inB ch?a d? li?u c?n n?p vào Accumulator
        end
        STO: begin
            // Ghi d? li?u t? Accumulator vào ??a ch? trong l?nh
            result = inA;  // Gi? ??nh inA ch?a d? li?u c?n ghi
        end
        JMP: begin
            // Nh?y ??n ??a ch? ch? ??nh trong câu l?nh
            result = inA;  // Dùng inA làm ??a ch? nh?y
        end
        default: begin
            result = 8'b00000000;  // Giá tr? m?c ??nh cho result
        end
    endcase

    // Thi?t l?p c? is_zero n?u k?t qu? là 0
    is_zero = (result == 8'b00000000) ? 1'b1 : 1'b0;
end

endmodule
