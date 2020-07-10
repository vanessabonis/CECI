module bancoRegistradores(A1, A2, A3, WD3, WE3, ck, reset_banco, RD1, RD2);

	input logic A1[5], A2[5];
	input logic [4:0] A3;
	input logic WD3, WE3, ck, reset_banco;
	output logic RD1, RD2;
	
	logic[31:0] saidaDecoder;
	logic[31:0] saidaAND;
	logic saidaRegister[32];
	
	decoder decodificador(A3, saidaDecoder);
	
	genvar i;
	
	generate 
		for(i = 0; i < 32; i++) begin: registrador
			and blocoAND(saidaAND[i], WE3, saidaDecoder[i]);
			flopenr registrador(ck, reset_banco, saidaAND[i], WD3, saidaRegister[i]);
		end
	endgenerate
	
	mux32 muxA(saidaRegister, A1, RD1);
	
	mux32 muxB(saidaRegister, A2, RD2);
	
endmodule 