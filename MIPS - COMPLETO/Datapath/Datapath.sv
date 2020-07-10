module Datapath(ck, reset_, IorD, RegDest, MemtoReg, IRWrite, RegWrite, ALUSrcA, ALUSrcB, ALUControl, PCSrc, 
					 Branch, PCWrite, WD, Adr, RD, overflow);
		
		input logic ck, reset_;
		input logic IorD, RegDest, MemtoReg, IRWrite, RegWrite, ALUSrcA, Branch, PCWrite;
		input logic[1:0] ALUSrcB, PCSrc;
		input logic[2:0] ALUControl;
		input logic[31:0] RD;
		output logic[31:0] Adr;
		output logic[31:0] WD;
		output logic overflow;
		
		logic zero, outputAND_PC, PCEn;
		logic[31:0] inputPC, outputPC, outputRegInstr, outputRegData, outputRegA, outputRegB, WD3, RD1, RD2;		
		logic[31:0] SrcA, SrcB, outputSignalExtension, outputShifter2, ALUOut, ALUResult;
		logic[4:0] outputMux5;
		logic[31:0] inputShifter2_2, outputShifterJump, jumpAddr;	
		
		and andPC(outputAND_PC, zero, Branch);
		or orPC(PCEn, outputAND_PC, PCWrite); 
		
		registradorEnReset PC(ck, reset_, PCEn, inputPC, outputPC);
		
		mux2 mux2_1(outputPC, ALUOut, IorD, Adr);
		
		registradorEnReset RegInstr(ck, reset_, IRWrite, RD, outputRegInstr);
		registradorReset RegData(ck, reset_, RD, outputRegData);
		
		mux2_5bits mux2_5bits(outputRegInstr[20:16], outputRegInstr[15:11], RegDest, outputMux5);
		mux2 mux2_2(ALUOut, outputRegData, MemtoReg, WD3); 

		bancoRegistradores bancoRegistradores(outputRegInstr[25:21], outputRegInstr[20:16], outputMux5, WD3, RegWrite, ck,
														  reset_, RD1, RD2);
														  
		registradorReset RegA(ck, reset_, RD1, outputRegA);
		registradorReset RegB(ck, reset_, RD2, outputRegB);
		
		assign WD = outputRegB;
		
		mux2 mux2_3(outputPC, outputRegA, ALUSrcA, SrcA);
		
		signalExtension signalExtension(outputRegInstr[15:0], outputSignalExtension); 
		
		shifter2 shifter2_1(outputSignalExtension, outputShifter2);
		
		mux4 mux4_1(outputRegB, 32'b00000000000000000000000000000100, outputSignalExtension, outputShifter2, ALUSrcB, SrcB);
														  
		ula32bits ula(ALUControl, SrcA, SrcB, ALUResult, overflow, zero);
		
		registradorReset RegULA(ck, reset_, ALUResult, ALUOut);
		
		assign inputShifter2_2[25:0] = outputRegInstr[25:0];
		assign inputShifter2_2[31:26] = 6'b000000;
		shifter2 shifter2_2(inputShifter2_2, outputShifterJump);
		
		assign jumpAddr = {outputPC[31:28], outputShifterJump[27:0]};
		
		mux4 mux4_2(.d0(ALUResult), .d1(ALUOut), .d2(jumpAddr), .s(PCSrc), .out(inputPC));
		
endmodule 
