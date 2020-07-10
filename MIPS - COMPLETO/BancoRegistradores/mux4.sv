module mux4(input logic d0, d1, d2, d3, s0, s1, 
		    output logic y); 
	logic low, high;
	
	mux2 lowmux(d0, d1, s0, low);
	mux2 highmux(d2, d3, s0, high);
	mux2 finalmux(low, high, s1, y);
endmodule
