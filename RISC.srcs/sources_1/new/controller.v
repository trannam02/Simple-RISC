module Controller(
    input clk,
    input rst,
    input [2:0] opcode, 
    input is_zero,
    
    output reg [2:0] alu_op = 3'b000,
    output reg is_jump = 1,
    output reg ar_load = 0, 
    output reg ar_mux = 0,
    output reg rw_mem = 0,
    output reg addr_mux = 0,
    output reg load = 0,
    output reg disable2 = 1 // tuong duong is_jump
);


localparam HLT = 3'b000;
localparam SKZ = 3'b001;
localparam ADD = 3'b010;
localparam AND = 3'b011;
localparam XOR = 3'b100;
localparam LDA = 3'b101;
localparam STO = 3'b110;
localparam JMP = 3'b111;

always @(opcode) begin
    case(opcode)
        HLT: begin // HLT
            alu_op = HLT;
            is_jump = 1'b0;
            ar_load = 1'b0;
            ar_mux = 1'b0;
            rw_mem = 1'b0;
            addr_mux = 1'b0;
            load = 1'b0;
            disable2 = 1'b0;
        end
        SKZ: begin // SKZ
            alu_op = 2'b000;
            if(is_zero) begin
                is_jump = 1'b0;  // khong cho load instruction moi
                disable2 = 1'b1; end
            else begin
                is_jump = 1'b1;
                disable2 = 1'b1; end
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
            disable2 = 1'b0;
        end
        AND: begin // AND
            alu_op = AND;
            is_jump = 1'b1;
            ar_load = 1'b1;
            ar_mux = 1'b0;
            rw_mem = 1'b0;
            addr_mux = 1'b1;
            load = 1'b0;
            disable2 = 1'b0;
        end
        XOR: begin // XOR
            alu_op = XOR;
            is_jump = 1'b1;
            ar_load = 1'b1;
            ar_mux = 1'b0;
            rw_mem = 1'b0;
            addr_mux = 1'b1;
            load = 1'b0;
            disable2 = 1'b0;
        end
        LDA: begin // LDA
            alu_op = LDA;
            is_jump = 1'b1;
            ar_load = 1'b1;
            ar_mux = 1'b1;
            rw_mem = 1'b0;
            addr_mux = 1'b1;
            load = 1'b0;
            disable2 = 1'b0;
        end
        STO: begin // STO
            alu_op = STO;
            is_jump = 1'b0;
            ar_load = 1'b1;
            ar_mux = 1'b1;
            rw_mem = 1'b1;
            addr_mux = 1'b1;
            load = 1'b0;
            disable2 = 1'b0; // chan
        end
        JMP: begin // JMP
            alu_op = JMP;
            is_jump = 1'b0;  // khong cho load instruction moi
            ar_load = 1'b0;
            ar_mux = 1'b0;
            rw_mem = 1'b0;
            addr_mux = 1'b0;
            load = 1'b1; // load preset
            disable2 = 1'b1; // tha
        end
        default: begin
            alu_op = JMP;
            is_jump = 1'b1;
            ar_load = 1'b0;
            ar_mux = 1'b0;
            rw_mem = 1'b0;
            addr_mux = 1'b0;
            load = 1'b0;
            disable2 = 1'b1; // tha
        end
    endcase
end


always @(negedge clk) begin

if(opcode) begin // (opcode != HLT) => normal  =======  (opcode == HLT) => is_jump = 0
    if (load) begin
        load = 1'b0;
    end
    if(!is_jump) begin
        is_jump = 1'b1;
    end
    if(!disable2) begin
        disable2 = 1'b1;
    end
    if(addr_mux) begin
        addr_mux = 1'b0;
    end
    if(ar_load) begin
            ar_load = 1'b0;
    end
    if(rw_mem) begin
        rw_mem = 1'b0;
    end
end

end

endmodule
