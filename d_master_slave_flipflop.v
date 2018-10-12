`timescale 1ns/100ps

module D_Latch(Q, QB, D, En);
	output 	Q, QB;
	input	D, En;
	wire	DB, W1, W2;
	
	not		#(05)not1(DB, D);
	nand	#(10)nand1(W1, D, En);
	nand	#(10)nand2(W2, DB, En);
	nand	#(10)nand3(Q, W1, QB);
	nand	#(10)nand4(QB, W2, Q);
endmodule

module D_MS_FF(Q, QB, D, CLK);
	output	Q, QB;
	input	D, CLK;
	wire	Y, CLKB;
	
	not		#(05)not1(CLKB, CLK);
	D_Latch	master(Y, , D, CLK);
	D_Latch	slave(Q, , Y, CLKB);
endmodule

module t_D_MS_FF;
	wire	Q, QB;
	reg		D, CLK;
	integer	k;
	
	D_MS_FF	M1(Q, , D, CLK);
	
	initial begin
		CLK = 1;
		D = 1;
		
		#70
		D = 0;
		#30
		CLK = 0;
		
		#100
		CLK = 1;
		
		#50
		D = 0;
		#50
		CLK = 0;
		
		#100
		CLK = 1;
		
		#30
		D = 1;
		#70
		CLK = 0;
		
		#100
		CLK = 1;
		
		#60
		D = 0;
		#40
		CLK = 0;
		
		#100
		CLK = 1;
		
		#90
		D = 1;
		#10
		CLK = 0;
		
		#100
		CLK = 1;
		
		#100
		CLK = 0;
		
		#100
		CLK = 1;
		
		#100
		CLK = 0;
		
		#100
		CLK = 1;
		
		#100
		CLK = 0;
		
		#100
		CLK = 1;
		
		#100
		CLK = 0;
		
		#50
		D = 0;
		#50
		CLK = 1;
		
		#100
		CLK = 0;
		
		#1
		D = 1;
		#91
		CLK = 1;
		
	end
	initial #3000 $finish;
	initial $dumpvars;
endmodule

/*
module t_D_Latch;
	wire	Q, QB;
	reg		D, En, CLK;
	
	D_Latch M(Q, QB, D, En);
	
	initial begin
		D = 1;
		En = 1;
		#200;
		D = 0;
		En = 1;
		#200;
		D = 1;
		En = 0;
		#200;
		D = 1;
		En = 1;
	end
	initial #2000 $finish;
	initial $dumpvars;
endmodule
*/