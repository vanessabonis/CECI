module flopenr(input logic clk, input logic reset, 
               input logic en, input logic d, 
					output logic q);
 
//Reset Assincrono
always @(posedge clk, posedge reset) 
	if (reset) q <= 1'b0; 
	else if (en) q <= d; 
endmodule



