`timescale 1ns/10ps

module mux2_5bits_tb();
	logic clk, reset;
	logic	s; 
	logic [4:0] d0;
	logic [4:0] d1;	
	logic	[4:0] out;
	logic	[4:0] out_expected;
	logic [31:0] vectornum, errors;
	logic [15:0] testvectors[10000:0];
	
	mux2_5bits duv(.d0(d0), .d1(d1), .s(s), .out(out));
	
	always
		begin
			clk = 1; #10; clk = 0; #5;
		end
		
		initial
			begin 
				$readmemb("mux2_5bits.tv", testvectors);
				vectornum = 0;
				errors = 0;
				reset = 1; #8; reset = 0;
			end
			
		always @ (posedge clk)
			begin
				#1 {d0[4:0], d1[4:0], s, out_expected[4:0]} = testvectors[vectornum];
			end
		always @ (negedge clk)
			
			if (~reset) begin
				
				for(reg [2:0] i = 3'b000; i < 3'b101; i++) begin
				assert (out[i] === out_expected[i]) else
					begin 
						$display("Error: inputs (%b e %b) in position %d - a = %b b = %b control = %b", d0, d1, i, d0[i], d1[i], s);
						$display(" output = %b, (%b expected)", out[i], out_expected[i]);
						
						errors = errors + 1;
					end;
				end
				
				vectornum = vectornum + 1;
				
				if(testvectors[vectornum] === 16'bx) begin
					$display("%d tests completed with %d errors", vectornum, errors);
					$finish;
				end
			end
endmodule 