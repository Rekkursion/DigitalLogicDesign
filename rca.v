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

module RCA_4bits(C0, A, B, Sum, C4);
	output	[3:0] Sum;
	output	C4;
	input	C0;
	input	[3:0] A;
	input	[3:0] B;
	wire	C1, C2, C3;
	
	Full_Adder	fa1(A[0], B[0], C0, Sum[0], C1);
	Full_Adder	fa2(A[1], B[1], C1, Sum[1], C2);
	Full_Adder	fa3(A[2], B[2], C2, Sum[2], C3);
	Full_Adder	fa4(A[3], B[3], C3, Sum[3], C4);
endmodule

module RCA_16bits(C0, A, B, Sum, C4);
	output	[15:0] Sum;
	output	C4;
	input	C0;
	input	[15:0] A;
	input	[15:0] B;
	wire	C1, C2, C3;
	
	RCA_4bits	rca_4bits1(C0, A[3:0], B[3:0], Sum[3:0], C1);
	RCA_4bits	rca_4bits2(C1, A[7:4], B[7:4], Sum[7:4], C2);
	RCA_4bits	rca_4bits3(C2, A[11:8], B[11:8], Sum[11:8], C3);
	RCA_4bits	rca_4bits4(C3, A[15:12], B[15:12], Sum[15:12], C4);
endmodule

module t_RCA_16bits;
	reg		[15:0] A;
	reg		[15:0] B;
	wire	[15:0] Sum;
	wire	Carry;
	
	RCA_16bits M1(1'b0, A, B, Sum, Carry);
	
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
