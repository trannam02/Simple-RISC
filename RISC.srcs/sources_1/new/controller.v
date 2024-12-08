module Controller(
    input clk,
    input rst,
    input [2:0] opcode, 
    input is_zero,
    
    output reg [2:0] alu_op = 3'b000,
    output reg ar_load = 0, 
    output reg ar_mux = 0,
    output reg rw_mem = 0,
    output reg addr_mux = 0,
    output reg load = 0,
    output reg load_ir_1 = 1, // from ex
    output reg load_ir_2 = 1  // from wb
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
            load_ir_1 = 1'b0;
            ar_load = 1'b0;
            ar_mux = 1'b0;
            rw_mem = 1'b0;
            addr_mux = 1'b0;
            load = 1'b0;
            load_ir_2 = 1'b0;
        end
        SKZ: begin // SKZ
            alu_op = 2'b000;
            if(is_zero) 
                load_ir_1 = 1'b0;  // khong cho load instruction moi
            else 
                load_ir_1 = 1'b1;
            ar_load = 1'b0;
            ar_mux = 1'b0;
            rw_mem = 1'b0;
            addr_mux = 1'b0;
            load = 1'b0;
            load_ir_2 = 1'b1;
        end
        ADD: begin // ADD
            alu_op = ADD;
            load_ir_1 = 1'b1;
            ar_load = 1'b1;
            ar_mux = 1'b0;
            rw_mem = 1'b0;
            addr_mux = 1'b1;
            load = 1'b0;
            load_ir_2 = 1'b0;
        end
        AND: begin // AND
            alu_op = AND;
            load_ir_1 = 1'b1;
            ar_load = 1'b1;
            ar_mux = 1'b0;
            rw_mem = 1'b0;
            addr_mux = 1'b1;
            load = 1'b0;
            load_ir_2 = 1'b0;
        end
        XOR: begin // XOR
            alu_op = XOR;
            load_ir_1 = 1'b1;
            ar_load = 1'b1;
            ar_mux = 1'b0;
            rw_mem = 1'b0;
            addr_mux = 1'b1;
            load = 1'b0;
            load_ir_2 = 1'b0;
        end
        LDA: begin // LDA
            alu_op = LDA;
            load_ir_1 = 1'b1;
            ar_load = 1'b1;
            ar_mux = 1'b1;
            rw_mem = 1'b0;
            addr_mux = 1'b1;
            load = 1'b0;
            load_ir_2 = 1'b0;
        end
        STO: begin // STO
            alu_op = STO;
            load_ir_1 = 1'b0;
            ar_load = 1'b0;
            ar_mux = 1'b0;
            rw_mem = 1'b1;
            addr_mux = 1'b1;
            load = 1'b0;
            load_ir_2 = 1'b0; // chan
        end
        JMP: begin // JMP
            alu_op = JMP;
            load_ir_1 = 1'b0;  // khong cho load instruction moi
            ar_load = 1'b0;
            ar_mux = 1'b0;
            rw_mem = 1'b0;
            addr_mux = 1'b0;
            load = 1'b1; // load preset
            load_ir_2 = 1'b1; // tha
        end
        default: begin
            alu_op = JMP;
            load_ir_1 = 1'b1;
            ar_load = 1'b0;
            ar_mux = 1'b0;
            rw_mem = 1'b0;
            addr_mux = 1'b0;
            load = 1'b0;
            load_ir_2 = 1'b1; // tha
        end
    endcase
end


always @(negedge clk) begin

if(opcode) begin // (opcode != HLT) => normal  =======  (opcode == HLT) => load_ir_1 = 0
    if (load) begin
        load = 1'b0;
    end
    if(!load_ir_1) begin
        load_ir_1 = 1'b1;
    end
    if(!load_ir_2) begin
        load_ir_2 = 1'b1;
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
