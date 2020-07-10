`timescale 1ns/100ps

module mux4_tb;
    
int counter, errors, aux_error;
logic clk,rst;
logic d0, d1, d2, d3;
logic s0;
logic s1;
logic y,y_esperado;
logic [6:0]vectors[9]; 

mux4 dut(d0, d1, d2, d3, s0, s1, y);

initial begin
	$display("Iniciando Testbench");
	$display("| D0 | D1 | D2 | D3 | S0 | S1 | Y |"); 
	$display("-----------------------------------");
	$readmemb("mux4_tv.tv",vectors);
	counter=0; errors=0;
	rst = 1; 
	#15; 
	rst = 0;		
end
		
always begin
    clk=1; #9; 
	clk=0; #2; 
end

always @(posedge clk)	//Sempre (que o clock subir)
	if(~rst)
	begin
		//Atribui valores do vetor nas entradas do DUT e nos valores esperados
		{d0, d1, d2, d3, s0, s1, y_esperado} = vectors[counter];	
	end

always @(negedge clk)	//Sempre (que o clock descer)
		if(~rst)
		begin
			aux_error = errors;
			
		assert (y === y_esperado)
		else	
		begin
			//Mostra mensagem de erro se a sa�da do DUT for diferente da sa�da esperada
			//$display("Error: input in position %d = %b", i, d0);
			$display("%d OP��O , output = %b, (%b expected)", s0, y, y_esperado);
						
			errors = errors + 1; //Incrementa contador de erros a cada bit errado encontrado
			end
			
		if(aux_error === errors)
			$display("| %b | %b | %b | %b | %b | %b | %b | OK", d0, d1, d2, d3, s0, s1, y);
		else
			$display("| %b | %b | %b | %b | %b | %b | %b | ERRO", d0, d1, d2, d3, s0, s1, y);

			counter++;	//Incrementa contador dos vertores de teste
			
			if(counter == $size(vectors)) //Quando os vetores de teste acabarem
			begin
				$display("Testes Efetuados  = %0d", counter);
				$display("Erros Encontrados = %0d", errors);
				#15
				$stop;
			end
			
		end
		
 endmodule