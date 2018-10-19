`timescale 1ns/100ps


module Shift_Register(A_par, I_par, CLK, LSB_in, MSB_in, Sel, Clear);
	output reg [3:0]	A_par;
	input [3:0]			I_par;
	input				CLK;
	input				Clear;
	input				LSB_in, MSB_in;
	input [1:0]			Sel;
	
	always @(posedge CLK or negedge Clear) begin
		if(!Clear) begin
			A_par <= 4'b0000;
		end
		else begin
			case (Sel)
				2'b00: ;
				2'b01: A_par <= {MSB_in, A_par[3:1]};
				2'b10: A_par <= {A_par[2:0], LSB_in};
				2'b11: A_par <= I_par;
				default: ;
			endcase
		end
	end
endmodule

module t_Shift_Register;
	wire [3:0]			A_par;
	reg [3:0]			I_par;
	reg 				CLK, LSB_in, MSB_in, Clear;
	reg [1:0]			Sel;
	
	Shift_Register M(A_par, I_par, CLK, LSB_in, MSB_in, Sel, Clear);
	
	initial begin
		I_par = 4'b0110;
		LSB_in = 1;
		MSB_in = 0;
		CLK = 0;
		Sel = 2'b11;
		
		#30; Clear = 1;
		#70; CLK = 1;
		
		#100; CLK = 0; Clear = 0;
		
		#30; Sel = 2'b10;
		#20; Clear = 1;
		#50; CLK = 1;
		
		#50; LSB_in = 0;
		#50; CLK = 0;
		
		#100; CLK = 1;
		
		#40; Sel = 2'b01;
		#60; CLK = 0;
		
		#100; CLK = 1;
		
		#39; MSB_in = ~MSB_in;
		#61; CLK = 0;
		
		#100; CLK = 1;
		
		#45; MSB_in = ~MSB_in;
		#55; CLK = 0;
		
		#40; Sel = 2'b11;
		#30; I_par = 4'b1101;
		#30; CLK = 1;
		
		#70; Sel = 2'b01;
		#30; CLK = 0;
		
		#100; CLK = 1;
		
		#34; Sel = 2'b00;
		#66; CLK = 0;
		
		#100; CLK = 1;
		
		#47; Sel = 2'b11;
		#53; CLK = 0;
		
		#100; CLK = 1;
		
	end
	initial #3000 $finish;
	initial $dumpvars;
	
endmodule
