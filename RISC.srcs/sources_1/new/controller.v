module Controller(
	input clk,
	input rst,
	input [2:0] opcode, 
	input is_zero,
	output reg stop,
	output reg [2:0] alu_op,
	output reg addr_mux,
	output reg rw_mem,	
	output reg ar_mux,
	output reg ar_load, 
	output reg is_jump,
	// reg skip va check_zero chi su dung noi bo de o day de quan sat duoc khi simulator
	output reg skip,
	output reg check_zero
);



localparam ADD = 3'b011;
localparam AND = 3'b010;
localparam XOR = 3'b100;

always @(posedge clk or posedge rst) begin
	if (rst) begin
		stop <= 1'b0;
		alu_op <= 2'b000;
		addr_mux <= 1'b0;

		rw_mem <= 1'b0;
		ar_mux <= 1'b0;
		ar_load <= 1'b0;
		is_jump <= 1'b0;
		skip <= 1'b0;
		check_zero <= 1'b0;
	end else if (skip) begin // bo qua lenh hien tai
		stop <= 1'b0;
		alu_op <= 2'b000;
		addr_mux <= 1'b0;

		rw_mem <= 1'b0;
		ar_mux <= 1'b0;
		ar_load <= 1'b0;
		is_jump <= 1'b0;
		skip <= 1'b0;
		check_zero <= 1'b0;
	end else begin
		// Xử lý theo opcode
		case(opcode)
			3'b000: begin // HLT
				stop <= 1'b1;
				alu_op <= 2'b000;
				addr_mux <= 1'b0;

				rw_mem <= 1'b0;
				ar_mux <= 1'b0;
				ar_load <= 1'b0;
				is_jump <= 1'b0;
				skip <= 1'b0;
				check_zero <= 1'b0;
			end
			3'b001: begin // SKZ
				stop <= 1'b0;
				alu_op <= 2'b000;
				addr_mux <= 1'b0;

				rw_mem <= 1'b0;
				ar_mux <= 1'b0;
				ar_load <= 1'b0;
				is_jump <= 1'b0;
				skip <= 1'b0;
				check_zero <= 1'b1; // kich hoat kiem tra alu
			end
			3'b010: begin // ADD
				stop <= 1'b0;
				alu_op <= ADD;
				addr_mux <= 1'b1; // chon addr trong data
				rw_mem <= 1'b0; // doc mem
				ar_mux <= 1'b0;   // ghi gia tri tu alu vao acc
				ar_load <= 1'b1; // ghi vao acc
				is_jump <= 1'b0;
				skip <= 1'b0;
				check_zero <= 1'b0;
			end
			3'b011: begin // AND
				stop <= 1'b0;
				alu_op <= AND;
				addr_mux <= 1'b1; // chon addr trong data
				rw_mem <= 1'b0; // doc mem
				ar_mux <= 1'b0; // ghi gia tri tu alu vao acc
				ar_load <= 1'b1; // ghi vao acc 
				is_jump <= 1'b0; 
				skip <= 1'b0;
				check_zero <= 1'b0;
			end
			3'b100: begin // XOR
				stop <= 1'b0;
				alu_op <= XOR;
				addr_mux <= 1'b1; // chon addr trong data
				rw_mem <= 1'b0; // doc mem
				ar_mux <= 1'b0; // ghi gia tri tu alu vao acc
				ar_load <= 1'b1; // ghi vao acc 
				is_jump <= 1'b0;
				skip <= 1'b0;
				check_zero <= 1'b0;
			end
			3'b101: begin // LDA
				stop <= 1'b0;
				alu_op <= 2'b000;
				addr_mux <= 1'b1; // chon addr trong data

				rw_mem <= 1'b0; // doc mem
				ar_mux <= 1'b1; // ghi gia tri tu mem vao acc
				ar_load <= 1'b1; // ghi vao acc
				is_jump <= 1'b0;
				skip <= 1'b0;
				check_zero <= 1'b0;
			end
			3'b110: begin // STO
				stop <= 1'b0;
				alu_op <= 2'b000;
				addr_mux <= 1'b1; // chon addr trong data
				
				rw_mem <= 1'b1; // viet vao mem
				ar_mux <= 1'b0;
				ar_load <= 1'b0;
				is_jump <= 1'b0;
				skip <= 1'b0;
				check_zero <= 1'b0;
			end
			3'b111: begin // JMP
				stop <= 1'b0;
				alu_op <= 2'b000;
				addr_mux <= 1'b0;
				
				rw_mem <= 1'b0;
				ar_mux <= 1'b0;
				ar_load <= 1'b0;
				is_jump <= 1'b1; // kich hoat jump
				skip <= 1'b1; // skip lenh tiep theo 
				check_zero <= 1'b0;
			end
			default: begin
				stop <= 1'b0;
				alu_op <= 2'b000;
				addr_mux <= 1'b0;
				
				rw_mem <= 1'b0;
				ar_mux <= 1'b0;
				ar_load <= 1'b0;
				is_jump <= 1'b0;
				skip <= 1'b0;
				check_zero <= 1'b0;
			end
		endcase
	end
end

always @(negedge clk) begin
	if (check_zero) begin
		if (is_zero) begin
			skip <= 1'b1; // kich hoat skip lenh tiep theo
		end
		check_zero <= 1'b0;
	end
end

endmodule
