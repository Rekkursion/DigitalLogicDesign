`timescale 100ns/1ps


module ALU(y, A, B, Sel);
	output reg [7:0] y;
	input [7:0] A;
	input [7:0] B;
	input [2:0] Sel;
	
	always @(A or B or Sel) begin
		case (Sel)
			3'b000: y = 8'b0;
			3'b001: y = A & B;
			3'b010: y = A | B;
			3'b011: y = A ^ B;
			3'b100: y = ~A;
			3'b101: y = A - B;
			3'b110: y = A + B;
			3'b111: y = 8'hFF;
			default: y = ~B;
		endcase
	end
	
endmodule

module t_ALU;
	wire [7:0] y;
	reg [7:0] A;
	reg [7:0] B;
	reg [2:0] Sel;
	
	ALU M1(y, A, B, Sel);
	
	initial begin
		Sel = 3'b000;
		A = 8'b11011101;
		B = 8'b10110111;
		
		$write("Current time:", $time, "\n");
		$monitor("A = %b, B = %b, y = %b", A, B, y);
		
		repeat(7) begin
			#100
			Sel = Sel + 1;
			
			$display("Current time: ", $time);
		end
	end
	initial #1000 $finish;
	initial $dumpvars;
endmodule
