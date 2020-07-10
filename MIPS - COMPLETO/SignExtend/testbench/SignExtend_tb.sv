`timescale 1ns / 100ps 
module SignExtend_tb;
	
logic clk, rst;
	logic [15:0] In;
	logic [31:0] Out, Out_esperado;
	logic [47:0] entrace [0:47];
	int counter,erros;

	SignExtend dut( .a(In), .y(Out) );
	always begin
		clk = 1; #10;
		clk = 0; #5;
	end
	
	initial begin
		counter = 0;
		erros = 0;
		$display ("Iniciando Test_bench");
		$readmemb ("SignExtend.tv", entrace);
		rst = 1;
		#20;
		rst = 0;
	end
	
	always @(posedge clk)
	if (~rst) begin 
		{In, Out_esperado} = entrace[counter][47:0];
	end
	always @(negedge clk)
	if (~rst) begin 
		for(int k = 0; k < 32; k++) begin
		  
			  assert (Out[k]=== Out_esperado[k]) else
				begin 
					  erros = erros + 1;
				end;
		end    
		counter = counter + 1;	
		if (entrace[counter] === 48'bx ) begin
			$display("número de testes efetuados = %d", counter);
			$display("número de erros encontrados = %d", erros);
			$stop;
		end
			
	end
		

endmodule
