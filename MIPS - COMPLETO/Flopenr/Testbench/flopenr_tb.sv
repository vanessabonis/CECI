`timescale 1ns/100ps
module flopenr_tb;
    
int counter, errors, aux_error;
logic clk,rst;
logic clk2,rst2;
logic d;
logic en;
logic q, q_esperado;
logic [4:0]vectors[16]; 
flopenr dut(clk2, rst2, en, d, q);

initial begin
	$display("Iniciando Testbench");
	$display("| CLK | RST | EN | D | Q |"); 
	$display("---------------");
	$readmemb("flopenr_tv.tv",vectors);
	counter=0; errors=0;
	rst = 1; 
	#15; 
	rst = 0;		
end
		
always
    begin
    clk=1; #10;
	clk=0; #5;
    end

always @(posedge clk)
	if(~rst)
	begin
		{clk2,rst2,en,d,q_esperado} = vectors[counter];	
	end

always @(negedge clk)	//Sempre (que o clock descer)
		if(~rst)
		begin
			aux_error = errors;
			assert (q === q_esperado)
		else	
		begin
			$display("%d linha , saída = %b, (%b esperado)",counter+1, q, q_esperado);
						
			errors = errors + 1; //Incrementa contador de erros a cada bit errado encontrado
			end
		if(aux_error === errors)
			$display("| %b | %b | %b | %b | %b | OK", clk2, rst2, en, d, q);
		else
			$display("| %b | %b | %b | %b | %b | ERROR", clk2, rst2, en, d, q);

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