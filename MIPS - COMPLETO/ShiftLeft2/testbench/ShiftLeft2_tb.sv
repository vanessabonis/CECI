`timescale 1ns / 100ps 
module ShiftLeft2_tb;
	
logic clk, rst;
	logic [31:0] In;
	logic [31:0] Out, Out_esperado;
	logic [63:0] entrance [4:0];
	int counter,erros;

	ShiftLeft2 duv( .A(In), .S(Out) );
	always begin
		clk = 1;
		#8;
		clk = 0;
		#5;
	end
	initial begin
		$display("Iniciando o o testbench");
		$readmemb("ShiftLeft2.tv",entrance);
		rst = 1;
		#13
		rst = 0;
		counter = 0;
		erros = 0;
	end
		
	always @(posedge clk)
	if (~rst) begin // skip during reset
		In = entrance[counter][63:32];
		Out_esperado = entrance[counter][31:0];
	end
	always @(negedge clk)
	if (~rst) begin // skip during reset
		for(int k = 0; k < 32; k++) begin
			 assert (Out[k]=== Out_esperado[k]) else
				begin 
					  $error("counter =%d",counter,"  Out%d",k,"=%b",Out[k],"  Out_esperado%d",k,"  =%b",Out_esperado[k]);
					  erros = erros + 1;
				end;
		end    
		counter = counter + 1;	
		if(entrance[counter] === 64'bx ) begin
				$display("Numero de testes efetuados = %d", counter);
				$display("Numero de erros encontrados = %d", erros);
			//$display("teste encerrado com testvector=%b",entrance[counter-1]);
			$stop;
		end
			
	end
		

endmodule
