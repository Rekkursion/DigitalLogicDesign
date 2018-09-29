`timescale 1ns/100ps

module Half_Adder(A, B, Sum, Cout);
	output	Sum, Cout;
	input	A, B;
	
	xor		#(20)xor1(Sum, A, B);
	and		#(10)and1(Cout, A, B);
endmodule

module Full_Adder(A, B, Cin, Sum, Cout);
	output	Sum, Cout;
	input	A, B, Cin;
	wire	HA1Sum, HA1Carry, HA2Carry;
	
	Half_Adder	ha1(A, B, HA1Sum, HA1Carry);
	Half_Adder	ha2(HA1Sum, Cin, Sum, HA2Carry);
	or			#(15)or1(Cout, HA1Carry, HA2Carry);
endmodule

module Carry_Calculator(C0, A, B, Carry);
	output	[15:0] Carry;
	input	C0;
	input	[15:0] A;
	input	[15:0] B;
	wire	[15:0] G, P;
	
	assign	#(10) G = A & B;
	assign	#(20) P = A ^ B;
	assign	Carry[0] = C0;
	
	genvar k;
	generate
		for(k = 1; k < 16; k = k + 1) begin
			assign #(25) Carry[k] = (P[k - 1] & Carry[k - 1]) | G[k - 1];
		end
	endgenerate
endmodule

module CLA(C0, A, B, Sum, C16);
	output	[15:0] Sum;
	output	C16;
	input	[15:0] A, B;
	input	C0;
	wire	[15:0] Carry;
	wire	dont_care;

	Carry_Calculator	CC(C0, A, B, Carry);
	Full_Adder			FA00(A[0], B[0], Carry[0], Sum[0], dont_care);
	Full_Adder			FA01(A[1], B[1], Carry[1], Sum[1], dont_care);
	Full_Adder			FA02(A[2], B[2], Carry[2], Sum[2], dont_care);
	Full_Adder			FA03(A[3], B[3], Carry[3], Sum[3], dont_care);
	Full_Adder			FA04(A[4], B[4], Carry[4], Sum[4], dont_care);
	Full_Adder			FA05(A[5], B[5], Carry[5], Sum[5], dont_care);
	Full_Adder			FA06(A[6], B[6], Carry[6], Sum[6], dont_care);
	Full_Adder			FA07(A[7], B[7], Carry[7], Sum[7], dont_care);
	Full_Adder			FA08(A[8], B[8], Carry[8], Sum[8], dont_care);
	Full_Adder			FA09(A[9], B[9], Carry[9], Sum[9], dont_care);
	Full_Adder			FA10(A[10], B[10], Carry[10], Sum[10], dont_care);
	Full_Adder			FA11(A[11], B[11], Carry[11], Sum[11], dont_care);
	Full_Adder			FA12(A[12], B[12], Carry[12], Sum[12], dont_care);
	Full_Adder			FA13(A[13], B[13], Carry[13], Sum[13], dont_care);
	Full_Adder			FA14(A[14], B[14], Carry[14], Sum[14], dont_care);
	Full_Adder			FA15(A[15], B[15], Carry[15], Sum[15], C16);
endmodule

module t_CLA;
	wire	[15:0] Sum;
	wire	C16;
	reg		[15:0] A;
	reg		[15:0] B;
	
	CLA M1(1'b0, A, B, Sum, C16);
	
	initial
		begin
			A = 16'b1010010100011011;
			B = 16'b0101001010111011;
			#1000
			A = 16'b0011011100101101;
			B = 16'b1111001101011001;
			#1000
			A = 16'b0101010101010101;
			B = 16'b1010101010101010;
			#1000
			A = 16'b1111111111111111;
			B = 16'b1111111111111111;
		end
	initial #4000 $finish;
	initial $dumpvars;
endmodule