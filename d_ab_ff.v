`timescale 1ns/100ps

module D_AB_FF(Q, D, CLK);
	output reg	Q;
	input		D, CLK;
	
	always @(posedge CLK) begin
		#(1) Q <= D;
	end
endmodule

module t_D_AB_FF;
	wire		Q;
	reg			D, CLK;
	
	D_AB_FF		M1(Q, D, CLK);
	
	initial begin
		CLK = 0;
		D = 1;
		
		#70 D = 0; #30 CLK = 1; #100 CLK = 0;
		#50 D = 0; #50 CLK = 1; #100 CLK = 0;
		#30 D = 1; #70 CLK = 1; #100 CLK = 0;
		#60 D = 0; #40 CLK = 1; #100 CLK = 0;
		#99 D = 1; #1 CLK = 1; #100 CLK = 0; #100 CLK = 1;
		#50 D = 0; #50 CLK = 0; #100 CLK = 1;
		#1 D = 1; #91 CLK = 0;
	end
	initial #2000 $finish;
	initial $dumpvars;
endmodule