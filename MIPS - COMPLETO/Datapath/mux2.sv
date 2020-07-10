module mux2(d0, d1, s, out);
	
	input logic [31:0] d0;
	input logic [31:0] d1;
	output logic [31:0] out;
	input logic s;
	
	always_comb begin 
		if(s == 1'b0)
			out = d0;
		else
			out = d1;
	end
	
endmodule 