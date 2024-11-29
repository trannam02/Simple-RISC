`timescale 1ns / 1ps

module ALU_tb;

    reg [7:0] inA;           // Toán h?ng ??u vào A
    reg [7:0] inB;           // Toán h?ng ??u vào B
    reg [2:0] opcode;        // Mã l?nh ?i?u khi?n
    wire [7:0] result;       // K?t qu? ??u ra
    wire is_zero;            // C? ki?m tra k?t qu? b?ng 0

    // Kh?i t?o mô-?un ALU
    ALU uut (
        .inA(inA),
        .inB(inB),
        .opcode(opcode),
        .result(result),
        .is_zero(is_zero)
    );

    // Kh?i t?o testbench
    initial begin

        $dumpfile("ALU_tb.vcd");
        $dumpvars(0, ALU_tb);

        // Test 1: L?nh HLT (000) - D?ng ho?t ??ng ch??ng trình
        opcode = 3'b000;
        inA = 8'b00000000;
        inB = 8'b00000000;
        #10;
        $display("Test HLT - Result: %b, is_zero: %b", result, is_zero);

        // Test 2: L?nh SKZ (001) - B? qua n?u k?t qu? b?ng 0
        opcode = 3'b001;
        inA = 8'b00000000;
        inB = 8'b00000000;
        #10;
        $display("Test SKZ (result = 0) - is_zero: %b", is_zero);

        // Test 3: L?nh SKZ (001) - Không b? qua n?u k?t qu? khác 0
        opcode = 3'b001;
        inA = 8'b00000001;
        inB = 8'b00000001;
        #10;
        $display("Test SKZ (result != 0) - is_zero: %b", is_zero);

        // Test 4: L?nh ADD (010) - C?ng 2 s? (5 + 10)
        opcode = 3'b010;
        inA = 8'b00000101;   // 5
        inB = 8'b00001010;   // 10
        #10;
        $display("Test ADD - Result: %d, is_zero: %b", result, is_zero);

        // Test 5: L?nh AND (011) - AND 2 s? (5 AND 3)
        opcode = 3'b011;
        inA = 8'b00000101;   // 5 (00000101)
        inB = 8'b00000011;   // 3 (00000011)
        #5;
        $display("Test AND - Result: %b, is_zero: %b", result, is_zero);

        opcode = 3'b011;
        inA = 8'b00000100;   // 5 (00000101)
        inB = 8'b00000011;   // 3 (00000011)
        #5

        // Test 6: L?nh XOR (100) - XOR 2 s? (5 XOR 3)
        opcode = 3'b100;
        inA = 8'b00000101;   // 5 (00000101)
        inB = 8'b00000011;   // 3 (00000011)
        #10;
        $display("Test XOR - Result: %b, is_zero: %b", result, is_zero);

        // Test 7: L?nh LDA (101) - N?p d? li?u vào Accumulator (inB = 15)
        opcode = 3'b101;
        inA = 8'b00000000;
        inB = 8'b00001111;   // 15
        #10;
        $display("Test LDA - Result: %d, is_zero: %b", result, is_zero);

        // Test 8: L?nh STO (110) - Ghi d? li?u t? Accumulator (inA = 20)
        opcode = 3'b110;
        inA = 8'b00010100;   // 20
        inB = 8'b00000000;
        #10;
        $display("Test STO - Result: %d, is_zero: %b", result, is_zero);

        // Test 9: L?nh JMP (111) - Nh?y ??n ??a ch? inA (gi? ??nh inA = 25)
        opcode = 3'b111;
        inA = 8'b00011001;   // 25
        inB = 8'b00000000;
        #10;
        $display("Test JMP - Result: %d, is_zero: %b", result, is_zero);

        // Test 10: L?nh ADD (010) - Ki?m tra is_zero khi k?t qu? là 0
        opcode = 3'b010;
        inA = 8'b00000001;   // 1
        inB = 8'b11111111;   // -1 (d?ng bù 2)
        #10;
        $display("Test ADD (result = 0) - Result: %d, is_zero: %b", result, is_zero);

        $finish;
    end
endmodule
