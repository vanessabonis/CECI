module shifter2(in, out);

input logic [31:0] in;
output logic [31:0] out;

assign out[31:2] = in[29:0];
assign out[1:0] = 2'b00;  

endmodule 