module meioSomador(input1, input2, output_s0, cout_0);

	input logic input1, input2;
	output logic output_s0, cout_0;
	
	assign output_s0 = input1 ^ input2;
	assign cout_0 = input1 & input2;
	
endmodule

module somador1bit(inputA, inputB, cin, output_s, cout);

	input logic inputA, inputB, cin;
	output logic output_s, cout;
	
	logic carry1, carry2, output_s1;
	
	meioSomador u1(inputA, inputB, output_s1, carry1);
	meioSomador u2(output_s1, cin, output_s, carry2);
	or u3(cout, carry1, carry2); 
	

endmodule 	