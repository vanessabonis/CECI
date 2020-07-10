module flopr(input logic clk, reset, d, output logic q);

//Reset Assincrono
always_ff @(posedge clk, posedge reset)
	if (reset) q <= 0;
	else q <= d;
endmodule


