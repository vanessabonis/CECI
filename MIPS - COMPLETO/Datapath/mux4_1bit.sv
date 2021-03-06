module mux4_1bit (d0, d1, d2, d3, s, out);
	
	input logic d0, d1, d2, d3;
	input logic [1:0] s;
	output logic out;
	
	logic out_0, out_1; 
	
	mux2_1bit muxZero(d0, d1, s[0], out_0);
	mux2_1bit muxUm(d2, d3, s[0], out_1);
	mux2_1bit muxDois(out_0, out_1, s[1], out);
	
endmodule 