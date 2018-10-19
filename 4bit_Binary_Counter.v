`timescale 1ns/100ps

module Binary_Counter_4bits(A_count, C_out, Data_in, CLK, Clear, Count, Load);
	output reg [3:0]	A_count;
	output reg			C_out;
	input [3:0]			Data_in;
	input				CLK;
	input				Clear;
	input				Count, Load;
	
	always @(posedge CLK or negedge Clear) begin
		if(!Clear) begin
			A_count <= 4'b0000;
		end
		else begin
			if(Load == 1) begin
				A_count <= Data_in;
			end
			else begin
				if(Count == 1) begin
					{C_out, A_count} <= A_count + 4'b0001;
				end
			end
		end
	end
endmodule

module t_Binary_Counter_4bits;
	wire [3:0]			A_count;
	wire				C_out;
	reg [3:0]			Data_in;
	reg 				CLK, Clear;
	reg					Count, Load;
	
	Binary_Counter_4bits M(A_count, C_out, Data_in, CLK, Clear, Count, Load);
	
	initial begin
		Data_in = 4'b0110;
		CLK = 0;
		Count = 1;
		Load = 1;
		
		#30; Clear = 1;
		#70; CLK = 1;
		
		#100; CLK = 0; Clear = 0;
		
		#30; Load = 0;
		#20; Clear = 1;
		#50; CLK = 1;
		
		#50; Count = 0;
		#50; CLK = 0;
		
		#100; CLK = 1;
		
		#40; Count = 1;
		#60; CLK = 0;
		
		#55; Load = 1;
		#45; CLK = 1;
		
		#51; Data_in = 4'b1010;
		#49; CLK = 0;
		
		#100; CLK = 1;
		
		#38; Load = 0;
		#62; CLK = 0;
		
		#100; CLK = 1;
		
		#100; CLK = 0;
		
		#100; CLK = 1;
		
		#100; CLK = 0;
		
		#100; CLK = 1;
		
		#100; CLK = 0;
		
		#100; CLK = 1;
		
		#100; CLK = 0;
		
		#100; CLK = 1;
		
		#100; CLK = 0;
		
		#100; CLK = 1;
		
		#100; CLK = 0;
		
		#100; CLK = 1;
		
		#100; CLK = 0;
		
		#100; CLK = 1;
		
		#100; CLK = 0;
		
		#100; CLK = 1;
		
		#100; CLK = 0;
		
		#100; CLK = 1;
	end
	initial #3000 $finish;
	initial $dumpvars;
	
endmodule
