module mux2_1bit(d0, d1, s, out);
	
	input logic d0;
	input logic d1;
	output logic out;
	input logic s;
	
	always_comb begin 
		if(s == 1'b0)
			out = d0;
		else
			out = d1;
	end
	
endmodule 