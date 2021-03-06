module mux8 (d0, d1, d2, d3, d4, d5, d6, d7, s, out);
	
	input logic d0, d1, d2, d3, d4, d5, d6, d7;
	input logic [2:0] s;
	output logic out;
	
	logic out_0, out_1; 
	
	mux4 muxZero(d0, d1, d2, d3, s[1:0], out_0);
	mux4 muxUm(d4, d5, d6, d7, s[1:0], out_1);
	mux2 muxDois(out_0, out_1, s[2], out);
	
endmodule 