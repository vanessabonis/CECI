module aggregatorShifter2(inputADDR, inputPC, out);

	input logic[25:0] inputADDR;
	input logic[3:0] inputPC;
	output logic[31:0] out;
	
	assign out[31:28] = inputPC[3:0];
	assign out[27:2] = inputADDR[25:0];
	assign out[1:0] = 2'b00;
	
endmodule 