module mux32(d0, d1, d2, d3, d4, d5, d6, d7,
				 d8, d9, d10, d11, d12, d13, d14, d15,
				 d16, d17, d18, d19, d20, d21, d22, d23,
				 d24, d25, d26, d27, d28, d29, d30, d31,
				 s, y);
	
	input logic [31:0] d0, d1, d2, d3, d4, d5, d6, d7;
	input logic [31:0] d8, d9, d10, d11, d12, d13, d14, d15;
	input logic [31:0] d16, d17, d18, d19, d20, d21, d22, d23;
	input logic [31:0] d24, d25, d26, d27, d28, d29, d30, d31;
	input logic [4:0] s;
	output logic [31:0] y;
	
	logic [31:0] y_0, y_1, y_2, y_3; 
	
	mux8 muxZero(d0, d1, d2, d3, d4, d5, d6, d7, s[2:0], y_0);
	mux8 muxUm(d8, d9, d10, d11, d12, d13, d14, d15, s[2:0], y_1);
	mux8 muxDois(d16, d17, d18, d19, d20, d21, d22, d23, s[2:0], y_2);
	mux8 muxTres(d24, d25, d26, d27, d28, d29, d30, d31, s[2:0], y_3);
	
	mux4 muxOut(y_0, y_1, y_2, y_3, s[4:3], y);
	
endmodule
