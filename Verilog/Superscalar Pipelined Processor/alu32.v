//-----
//alu32.v
//-----

`timescale 1ns / 1ps

module alu (input [31:0] A, B, 
			input [3:0] F, 
			input [4:0] shamt,
			output reg [31:0] Y);
	
	wire [31:0] S, Bout;
	
	assign Bout = F[3] ? ~B : B;
	assign S = A + Bout + F[3];

	always @ ( * )
		case (F[2:0])
			3'b000: Y <= A & Bout;
			3'b001: Y <= A | Bout;
			3'b010: Y <= S;
			3'b011: Y <= S[31];
			3'b100: Y <= (Bout << shamt);
		endcase

endmodule