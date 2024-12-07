module Controller(
    input clk,
    input rst,
    input [2:0] opcode, 
    input is_zero,
    
    output reg [2:0] alu_op,
    output reg is_jump,
    output reg ar_load, 
    output reg ar_mux,
    output reg rw_mem,
    output reg addr_mux,
    output reg load
);


localparam HLT = 3'b000;
localparam SKZ = 3'b001;
localparam ADD = 3'b010;
localparam AND = 3'b011;
localparam XOR = 3'b100;
localparam LDA = 3'b101;
localparam STO = 3'b110;
localparam JMP = 3'b111;

always @(*) begin
    case(opcode)
        HLT: begin // HLT
            alu_op = HLT;
            is_jump = 1'b0;
            ar_load = 1'b0;
            ar_mux = 1'b0;
            rw_mem = 1'b0;
            addr_mux = 1'b0;
            load = 1'b0;
        end
        SKZ: begin // SKZ
            alu_op = 2'b000;
            if(is_zero)
                is_jump = 1'b0;  // khong cho load instruction moi
            ar_load = 1'b0;
            ar_mux = 1'b0;
            rw_mem = 1'b0;
            addr_mux = 1'b0;
            load = 1'b0;
        end
        ADD: begin // ADD
            alu_op = ADD;
            is_jump = 1'b1;
            ar_load = 1'b1;
            ar_mux = 1'b0;
            rw_mem = 1'b0;
            addr_mux = 1'b1;
            load = 1'b0;
        end
        AND: begin // AND
            alu_op = AND;
            is_jump = 1'b1;
            ar_load = 1'b1;
            ar_mux = 1'b0;
            rw_mem = 1'b0;
            addr_mux = 1'b1;
            load = 1'b0;
        end
        XOR: begin // XOR
            alu_op = XOR;
                    is_jump = 1'b1;
                    ar_load = 1'b1;
                    ar_mux = 1'b0;
                    rw_mem = 1'b0;
                    addr_mux = 1'b1;
                    load = 1'b0;
        end
        LDA: begin // LDA
            alu_op = LDA;
            is_jump = 1'b1;
            ar_load = 1'b1;
            ar_mux = 1'b1;
            rw_mem = 1'b0;
            addr_mux = 1'b1;
            load = 1'b0;
        end
        STO: begin // STO
            alu_op = STO;
            is_jump = 1'b1;
            ar_load = 1'b1;
            ar_mux = 1'b1;
            rw_mem = 1'b1;
            addr_mux = 1'b1;
            load = 1'b0;
        end
        JMP: begin // JMP
            alu_op = JMP;
            is_jump = 1'b0;  // khong cho load instruction moi
            ar_load = 1'b0;
            ar_mux = 1'b0;
            rw_mem = 1'b0;
            addr_mux = 1'b0;
            load = 1'b1; // load preset
        end
        default: begin
            alu_op = JMP;
            is_jump = 1'b1;
            ar_load = 1'b0;
            ar_mux = 1'b0;
            rw_mem = 1'b0;
            addr_mux = 1'b0;
            load = 1'b0;
        end
    endcase
end


always @(negedge clk) begin

if(opcode) begin // (opcode != HLT) => normal  =======  (opcode == HLT) => is_jump = 0
    if (load) begin
        load = 1'b0;
    end
    if(is_jump) begin
       is_jump = 1'b0;
    end
end

end

endmodule
