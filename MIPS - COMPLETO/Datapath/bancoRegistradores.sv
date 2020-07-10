module bancoRegistradores(A1, A2, A3, WD3, WE3, ck, reset_bank, RD1, RD2);

	input logic[4:0] A1, A2, A3;
	input logic[31:0] WD3;
	input logic WE3, ck, reset_bank;
	output logic[31:0] RD1, RD2;
	
	logic[31:0] outputDecoder;
	logic[31:0] outputAND;
	logic[31:0] outputRegister[31:0];
	
	decoder decoder(A3, outputDecoder);
	
	genvar i;
	
	generate 
		for(i = 0; i < 32; i++) begin: registrador
			and blocoAND(outputAND[i], WE3, outputDecoder[i]);
			registradorEnReset registrador(ck, reset_bank, outputAND[i], WD3, outputRegister[i]);
		end
	endgenerate
	
	mux32 muxA(outputRegister[0], outputRegister[1], outputRegister[2], outputRegister[3],
				  outputRegister[4], outputRegister[5], outputRegister[6], outputRegister[7],
				  outputRegister[8], outputRegister[9], outputRegister[10], outputRegister[11],
				  outputRegister[12], outputRegister[13], outputRegister[14], outputRegister[15],
				  outputRegister[16], outputRegister[17], outputRegister[18], outputRegister[19],
				  outputRegister[20], outputRegister[21], outputRegister[22], outputRegister[23],
				  outputRegister[24], outputRegister[25], outputRegister[26], outputRegister[27],
				  outputRegister[28], outputRegister[29], outputRegister[30], outputRegister[31], A1, RD1);
	
	
	mux32 muxB(outputRegister[0], outputRegister[1], outputRegister[2], outputRegister[3],
				  outputRegister[4], outputRegister[5], outputRegister[6], outputRegister[7],
				  outputRegister[8], outputRegister[9], outputRegister[10], outputRegister[11],
				  outputRegister[12], outputRegister[13], outputRegister[14], outputRegister[15],
				  outputRegister[16], outputRegister[17], outputRegister[18], outputRegister[19],
				  outputRegister[20], outputRegister[21], outputRegister[22], outputRegister[23],
				  outputRegister[24], outputRegister[25], outputRegister[26], outputRegister[27],
				  outputRegister[28], outputRegister[29], outputRegister[30], outputRegister[31], A2, RD2);
	
endmodule 