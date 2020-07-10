`timescale 1ns/10ps

module ULA_1bit_tb();
	logic clk, reset;
	logic [2:0] ALUcontrol;
	logic A;
	logic B;
	logic cin;
	logic addSubSignal;
	logic ALUresult;
	logic ALUresult_expected;
	logic [31:0] vectornum, errors;
	logic [7:0] testvectors[10000:0];
	
	ULA_1bit duv(.ALUcontrol(ALUcontrol), .A(A), .B(B), .cin(cin), .addSubSignal(addSubSignal), .ALUresult(ALUresult));

	always
		begin
			clk = 1; #15; clk = 0; #5;
		end
		
		initial
			begin 
				$readmemb("ULA_1bit.tv", testvectors);
				vectornum = 0;
				errors = 0;
				reset = 1; #8; reset = 0;
			end
			
		always @ (posedge clk)
			begin
				#1 {ALUcontrol[2:0], A, B, cin, addSubSignal, ALUresult_expected} = testvectors[vectornum];
			end
		always @ (negedge clk)
			if (~reset) begin
					assert (ALUresult === ALUresult_expected) else 
					 begin
						if(ALUresult_expected !== 1'bx) begin
							$display("Line with error: %1d", vectornum + 1);
							$display("Error: A: %b B: %b", A, B);
							$display(" output = %b, (%b expected)", ALUresult, ALUresult_expected);
							errors = errors + 1;
						end
					 end
				
				vectornum = vectornum + 1;
				
				if(testvectors[vectornum] === 8'bx) begin
					$display("%d testes finalizados com %d erros", vectornum, errors);
					$finish;
				end
			end
endmodule
