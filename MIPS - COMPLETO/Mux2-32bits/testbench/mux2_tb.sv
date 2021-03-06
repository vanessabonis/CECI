`timescale 1ns/10ps

module mux2_tb();
	logic clk, reset;
	logic	s; 
	logic [31:0] d0;
	logic [31:0] d1;	
	logic	[31:0] out;
	logic	[31:0] out_expected;
	logic [31:0] vectornum, errors;
	logic [96:0] testvectors[10000:0];
	
	mux2 duv(.d0(d0), .d1(d1), .s(s), .out(out));
	
	always
		begin
			clk = 1; #10; clk = 0; #5;
		end
		
		initial
			begin 
				$readmemb("mux2.tv", testvectors);
				vectornum = 0;
				errors = 0;
				reset = 1; #8; reset = 0;
			end
			
		always @ (posedge clk)
			begin
				#1 {d0[31:0], d1[31:0], s, out_expected[31:0]} = testvectors[vectornum];
			end
		always @ (negedge clk)
			
			if (~reset) begin
				
				for(reg [5:0] i = 6'b000000; i < 6'b100000; i++) begin
				assert (out[i] === out_expected[i]) else
					begin 
						$display("Error: inputs (%b e %b) in position %d - a = %b b = %b control = %b", d0, d1, i, d0[i], d1[i], s);
						$display(" output = %b, (%b expected)", out[i], out_expected[i]);
						
						errors = errors + 1;
					end;
				end
				
				vectornum = vectornum + 1;
				
				if(testvectors[vectornum] === 97'bx) begin
					$display("%d tests completed with %d errors", vectornum, errors);
					$finish;
				end
			end
endmodule 