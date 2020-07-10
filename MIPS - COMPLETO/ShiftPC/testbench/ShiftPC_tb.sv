`timescale 1ns/10ps
module ShiftPC_tb();

logic clk,rst;
logic [3:0]	PC;
logic [25:0] A;
logic [31:0] S;
logic [31:0] S_esperado;
logic [63:0]vector_ind,erros;
logic [61:0] testvectors[4:0];

ShiftPC DUV(.PC(PC),.A(A),.S(S));

always
    begin
    clk =1; #8; clk=0; #5;
    end
	 
initial begin
	$readmemb("ShiftPC.tv",testvectors);
	vector_ind=0; erros=0;
	rst=1; #8; rst=0;

end
always @(posedge clk)
begin

	{PC[3:0],A[25:0],S_esperado[31:0]} = testvectors[vector_ind];

end
always @(negedge clk)
if (~rst) begin
	if (S !== S_esperado) begin
		$display("Erro: entradas= %b",{A});
		$display("S = %b (%b esperado)",S,S_esperado);
		erros = erros + 1;
	end
	
	vector_ind = vector_ind + 1;
	
	if(testvectors[vector_ind] === 62'bx) begin
		$display("%d testes realizados com %d erros", vector_ind, erros);
		$stop;
	end
end
endmodule