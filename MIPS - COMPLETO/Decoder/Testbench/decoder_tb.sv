`timescale 1ns/10ps

module decoder_tb();
	logic clk, reset;
	logic [4:0] Sel;
	logic [31:0] Output;
	logic	[31:0] output_selector_expected;
	logic [31:0] vectornum, errors;
	logic [36:0] testvectors[10000:0];
	
	decoder duv(.Sel(Sel), .Output(Output));

	always
		begin
			clk = 1; #20; clk = 0; #10;
		end
		
		initial
			begin 
				$readmemb("decoder.tv", testvectors);
				vectornum = 0;
				errors = 0;
				reset = 1; #8; reset = 0;
			end
			
		always @ (posedge clk)
			begin
				#1 {Sel[4:0], output_selector_expected[31:0]} = testvectors[vectornum];
			end
		always @ (negedge clk)
			if (~reset) begin
				for(reg[5:0] i = 6'b000000; i < 6'b100000; i++) begin
					assert (Output[i] === output_selector_expected[i]) else 
					 begin
						if(output_selector_expected[i] !== 1'bx) begin
							$display("Erro na linha: %1d", vectornum + 1);
							$display("Error: Entrada (%b) na posição %d = %b", Sel, i, Sel[i]);
							$display(" output = %b, (%b Esperado)", Output[i], output_selector_expected[i]);
						
							errors = errors + 1;
						end
					 end
				end
				
				vectornum = vectornum + 1;
				
				if(testvectors[vectornum] === 37'bx) begin
					$display("%d testes executados com %d errors", vectornum, errors);
					$finish;
				end
			end
endmodule
