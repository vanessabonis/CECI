`timescale 1ns/10ps

module registradorReset_tb();
	logic clk, reset;
	logic ck;
	logic reset_register;
	logic [31:0] in;
	logic [31:0] out;
	logic	[31:0] out_expected;
	logic [31:0] vectornum, errors;
	logic [65:0] testvectors[10000:0];
	
	registradorReset duv(.ck(ck), .reset_register(reset_register), .in(in), .out(out));

	always
		begin
			clk = 1; #5; clk = 0; #5;
		end
		
		initial
			begin 
				$readmemb("registradorReset.tv", testvectors);
				vectornum = 0;
				errors = 0;
				reset = 1; #8; reset = 0;
			end
			
		always @ (posedge clk)
			begin
				#1 {ck, reset_register, in[31:0], out_expected[31:0]} = testvectors[vectornum];
			end
		always @ (negedge clk)
			if (~reset) begin
				for(reg[5:0] i = 6'b000000; i < 6'b100000; i++) begin
					assert (out[i] === out_expected[i]) else 
					 begin
						if(out_expected[i] !== 1'bx) begin
							$display("Line with error: %1d", vectornum + 1);
							$display("Error: input: %b, ck: %b, reset: %b", in, ck, reset_register);
							$display(" output = %b, (%b expected)", out[i], out_expected[i]);
						
							errors = errors + 1;
						end
					 end
				end
				
				vectornum = vectornum + 1;
				
				if(testvectors[vectornum] === 66'bx) begin
					$display("%d tests completed with %d errors", vectornum, errors);
					$finish;
				end
			end
endmodule
