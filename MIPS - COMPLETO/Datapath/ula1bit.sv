module ula1bit(ALUcontrol, SrcA, SrcB, cin, addSubSignal, less, set, ALUresult, cout);

	input logic[2:0] ALUcontrol;
	input logic SrcA, SrcB, addSubSignal, cin, less;
	output logic set, ALUresult, cout;
	
	logic OutputAND, OutputNAND, OutputOR, OutputNOR, OutputXOR, OutputSomador, B_or_Complement2;
	
	and andULA(OutputAND, SrcA, SrcB);
	nand nandULA(OutputNAND, SrcA, SrcB);
	or orULA(OutputOR, SrcA, SrcB);
	nor norULA(OutputNOR, SrcA, SrcB);
	xor xorULA(OutputXOR, SrcA, SrcB);
	
	xor addSub(B_or_Complement2, SrcB, addSubSignal);
	
	somador1bit somadorULA(SrcA, B_or_Complement2, cin, OutputSomador, cout);
	
	assign set = OutputSomador;
	
	mux8_1bit muxULA(OutputAND, OutputOR, OutputSomador, OutputNOR, OutputXOR, OutputNAND, OutputSomador, 
					     less, ALUcontrol, ALUresult);
	
endmodule 
