`timescale 1ns/100ps

module D_ET_FF(Q, QB, D, CLK);
	output	Q, QB;
	input	D, CLK;
	wire	w1, w2, S, R;
	
	nand	#(10)nand1(w1, w2, S);
	nand	#(10)nand2(S, CLK, w1);
	nand	#(15)nand3(R, S, CLK, w2);
	nand	#(10)nand4(w2, R, D);
	nand	#(10)nand5(Q, S, QB);
	nand	#(10)nand6(QB, R, Q);
endmodule

module t_D_ET_FF;
	wire	Q, QB;
	reg		D, CLK;
	
	D_ET_FF	M1(Q, QB, D, CLK);
	
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