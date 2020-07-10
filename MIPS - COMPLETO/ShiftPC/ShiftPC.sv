module ShiftPC (input logic [3:0] PC, 
                input logic [25:0] A, 
					 output logic [31:0] S);
					 
		assign S = {PC,A,2'b00};

endmodule


