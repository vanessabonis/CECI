module ula32bits(ALUcontrol, SrcA, SrcB, ALUresult, overflow, zero);

	input logic[2:0] ALUcontrol;
	input logic[31:0] SrcA, SrcB;
	output logic[31:0] ALUresult;
	output logic overflow, zero;
	
	logic[31:0] cout;
	logic[31:0] set;
	
	logic addSubSignal;
	
	assign addSubSignal = (ALUcontrol == 1'b110 || ALUcontrol == 1'b111) ? 1'b1 : 1'b0;
	
	ula1bit ula0(ALUcontrol, SrcA[0], SrcB[0], addSubSignal, addSubSignal, set[31], set[0], ALUresult[0], cout[0]);
	
	genvar i;
	
	generate 
		for(i = 1; i < 32; i++) begin: ula
			ula1bit ula(ALUcontrol, SrcA[i], SrcB[i], cout[i-1], addSubSignal, 1'b0, set[i], ALUresult[i], cout[i]);
		end
	endgenerate
	
	xor overflowDetector(overflow, cout[31], cout[30]);
	nor zeroDetector(zero, ALUresult[31], ALUresult[30], ALUresult[29], ALUresult[28], ALUresult[27], ALUresult[26], ALUresult[25], ALUresult[24],
						ALUresult[23], ALUresult[22], ALUresult[21], ALUresult[20], ALUresult[19], ALUresult[18], ALUresult[17], ALUresult[16],
						ALUresult[15], ALUresult[14], ALUresult[13], ALUresult[12], ALUresult[11], ALUresult[10], ALUresult[9], ALUresult[8],
						ALUresult[7], ALUresult[6], ALUresult[5], ALUresult[4], ALUresult[3], ALUresult[2], ALUresult[1], ALUresult[0]);
	
endmodule
