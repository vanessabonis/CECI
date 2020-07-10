module signalExtension(in, out);

input logic [15:0] in;
output logic [31:0] out;

assign out = in[15] ? in + 32'b11111111111111110000000000000000 : in;

endmodule 