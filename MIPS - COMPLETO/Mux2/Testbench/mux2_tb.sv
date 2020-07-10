`timescale 1ns/100ps

module mux2_tb;
    
int counter, errors, aux_error;
logic clk,rst;
logic d0,d1;
logic s;
logic ns;
logic y,y_esperado;
logic [3:0]vectors[9]; 

mux2 dut(d0, d1, s, y);

initial begin
	$display("Iniciando Testbench");
	$display("| D0 | D1 | S | Y |"); 
	$display("---------------");
	$readmemb("mux2_tv.tv",vectors);
	counter=0; errors=0;
	rst = 1; 
	#15; 
	rst = 0;		
end
		
always begin
    clk=1; #10; 
	clk=0; #5; 
end

always @(posedge clk)	//Sempre (que o clock subir)
	if(~rst)
	begin
		//Atribui valores do vetor nas entradas do DUT e nos valores esperados
		{d0,d1,s,y_esperado} = vectors[counter];	
	end

always @(negedge clk)	//Sempre (que o clock descer)
		if(~rst)
		begin
			aux_error = errors;
	
		assert (y === y_esperado)
		else	
		begin
			//Mostra mensagem de erro se a sa�da do DUT for diferente da sa�da esperada
			$display("Error: input = %b", d0);
			$display("%d OPCAO , output = %b, (%b expected)",s, y, y_esperado);
						
			errors = errors + 1; //Incrementa contador de erros a cada bit errado encontrado
			end
		if(aux_error === errors)
			$display("| %b | %b | %b | %b | OK", d0, d1, s, y);
		else
			$display("| %b | %b | %b | %b | ERROR", d0, d1, s, y);

			counter++;	//Incrementa contador dos vertores de teste
			
			if(counter == $size(vectors)) //Quando os vetores de teste acabarem
			begin
				$display("Testes Efetuados  = %0d", counter);
				$display("Erros Encontrados = %0d", errors);
				#10
				$stop;
			end
			
		end
		
 endmodule