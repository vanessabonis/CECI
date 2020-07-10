module ShiftLeft2 (input logic [31:0] A, output logic [31:0] S);

		assign S = {A[29:0], 2'b00};

endmodule


