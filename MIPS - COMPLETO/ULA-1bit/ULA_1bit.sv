module ULA_1bit(ALUcontrol, A, B, cin, addSubSignal, less, set, ALUresult, cout);

	input logic[2:0] ALUcontrol;
	input logic A, B, addSubSignal, cin, less;
	output logic set, ALUresult, cout;
	
	logic OutputAND, OutputNAND, OutputOR, OutputNOR, OutputXOR, OutputSomador, B_or_Complement2;
	
	and andULA(OutputAND, A, B);
	nand nandULA(OutputNAND, A, B);
	or orULA(OutputOR, A, B);
	nor norULA(OutputNOR, A, B);
	xor xorULA(OutputXOR, A, B);
	
	xor addSub(B_or_Complement2, B, addSubSignal);
	
	somador1bit somadorULA(A, B_or_Complement2, cin, OutputSomador, cout);
	
	assign set = OutputSomador;
	
	mux8 muxULA(OutputAND, OutputOR, OutputSomador, OutputNOR, OutputXOR, OutputNAND, OutputSomador, less, ALUcontrol, ALUresult);
	
endmodule 
