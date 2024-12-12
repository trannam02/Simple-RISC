module Controller(
    input clk,
    input [2:0] opcode, 
    input is_zero,
    
    output [2:0] o_alu_op,
    output o_ar_load, 
    output o_ar_mux,
    output o_rw_mem,
    output o_addr_mux,
    output o_load,
    output o_load_ir_1, // from ex
    output o_load_ir_2  // from wb
//    output o_stop_counter
);

localparam HLT = 3'b000;
localparam SKZ = 3'b001;
localparam ADD = 3'b010;
localparam AND = 3'b011;
localparam XOR = 3'b100;
localparam LDA = 3'b101;
localparam STO = 3'b110;
localparam JMP = 3'b111;

// signal
reg [2:0] alu_op = 3'b111;
reg ar_load = 0;
reg ar_mux = 0;
reg rw_mem = 0;
reg addr_mux = 0;
reg load = 0;
reg load_ir_1 = 1; // from ex
reg load_ir_2 = 1;  // from wb
//reg stop_counter = 0;

// default signal
reg [2:0] default_alu_op = 3'b111;
reg default_ar_load = 0;
reg default_ar_mux = 0;
reg default_rw_mem = 0;
reg default_addr_mux = 0;
reg default_load = 0;
reg default_load_ir_1 = 1; // from ex
reg default_load_ir_2 = 1;  // from wb
//reg default_stop_counter = 0;

// edge detecter
reg [2:0] reg0 = 0;
reg [2:0] reg1 = 0;
wire edge_detected;

always @(opcode or clk) begin
reg0 <= opcode;
reg1 <= reg0;
case(opcode)
    HLT: begin // HLT
        alu_op = HLT;
        load_ir_1 = 1'b0;
        ar_load = 1'b0;
        ar_mux = 1'b1;
        rw_mem = 1'b0;
        addr_mux = 1'b0;
        load = 1'b0;
        load_ir_2 = 1'b0;
//        stop_counter = 1'b1;
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
//         stop_counter = 1'b0;
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
//        stop_counter = 1'b0;
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
//        stop_counter = 1'b0;
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
//        stop_counter = 1'b0;
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
//        stop_counter = 1'b0;
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
//        stop_counter = 1'b0;
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
//        stop_counter = 1'b0;
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
//        stop_counter = 1'b0;
    end
endcase
end

assign edge_detected = (reg0 ^ reg1) ? 1'b1 : 1'b0;

wire is_hlt;
//assign is_hlt = ar_mux & ~ar_load;

assign {
    o_alu_op,
    o_ar_load,
    o_ar_mux,
    o_rw_mem,
    o_addr_mux,
    o_load,
    o_load_ir_1,
    o_load_ir_2
//    o_stop_counter
} = edge_detected ? 
{
    alu_op,
    ar_load,
    ar_mux,
    rw_mem,
    addr_mux,
    load,
    load_ir_1,
    load_ir_2
//    stop_counter
} :
{
    default_alu_op,
    default_ar_load,
    default_ar_mux,
    default_rw_mem,
    default_addr_mux,
    default_load,
    default_load_ir_1,
    default_load_ir_2
//    default_stop_counter
};

endmodule