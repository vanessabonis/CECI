`timescale 1ns/10ps

module Datapath_tb();
	logic clk, reset;
	logic ck, reset_;
	logic IorD, RegDest, MemtoReg, IRWrite, RegWrite, ALUSrcA, Branch, PCWrite;
	logic[1:0] ALUSrcB, PCSrc;
	logic[2:0] ALUControl;
	logic[31:0] RD;
	logic[31:0] Adr;
	logic[31:0] WD;
	logic overflow;
	logic[31:0] Adr_expected;
	logic[31:0] WD_expected;
	logic overflow_expected;
	logic [31:0] vectornum, errors;
	logic [113:0] testvectors[10000:0];
	
	Datapath duv(.ck(ck), .reset_(reset_), .IorD(IorD), .RegDest(RegDest), .MemtoReg(MemtoReg), .IRWrite(IRWrite), 
					 .RegWrite(RegWrite), .ALUSrcA(ALUSrcA), .ALUSrcB(ALUSrcB), .ALUControl(ALUControl), .PCSrc(PCSrc), 
					 .Branch(Branch), .PCWrite(PCWrite), .WD(WD), .Adr(Adr), .RD(RD), .overflow(overflow));
	always
		begin
			clk = 1; #25; clk = 0; #5;
		end
		
		initial
			begin 
				$readmemb("Datapath.tv", testvectors);
				vectornum = 0;
				errors = 0;
				reset = 1; #8; reset = 0;
			end
			
		always @ (posedge clk)
			begin
				#1 {ck, reset_, IorD, IRWrite, RegDest, MemtoReg, RegWrite, ALUSrcA, ALUSrcB, ALUControl, Branch, PCWrite,
				PCSrc, RD, Adr_expected, WD_expected, overflow_expected} = testvectors[vectornum];
			end
		always @ (negedge clk)
			if (~reset) begin
				for(reg[5:0] i = 6'b000000; i < 6'b100000; i++) begin
					assert (Adr[i] === Adr_expected[i]) else 
					 begin
						if(Adr_expected[i] !== 1'bx) begin
							$display("Line with error: %1d", vectornum + 1);
							$display("Error: ck: %b, reset_: %b, IorD: %b, IRWrite: %b,", ck, reset_, IorD, IRWrite); 
							$display(" RegDest: %b, MemtoReg: %b, RegWrite: %b,", RegDest, MemtoReg, RegWrite);
							$display(" ALUSrcA: %b, ALUSrcB: %b, ALUControl: %b,", ALUSrcA, ALUSrcB, ALUControl);
							$display(" Branch: %b, PCWrite: %b, PCSrc: %b, RD: %b", Branch, PCWrite, PCSrc, RD);
							$display(" Adr[%d] = %b, (%b expected)", i, Adr[i], Adr_expected[i]);
						
							errors = errors + 1;
						end
					 end
					 assert (WD[i] === WD_expected[i]) else 
					 begin
						if(WD_expected[i] !== 1'bx) begin
							$display("Line with error: %1d", vectornum + 1);
							$display("Error: ck: %b, reset_: %b, IorD: %b, IRWrite: %b,", ck, reset_, IorD, IRWrite); 
							$display(" RegDest: %b, MemtoReg: %b, RegWrite: %b,", RegDest, MemtoReg, RegWrite);
							$display(" ALUSrcA: %b, ALUSrcB: %b, ALUControl: %b,", ALUSrcA, ALUSrcB, ALUControl);
							$display(" Branch: %b, PCWrite: %b, PCSrc: %b, RD: %b", Branch, PCWrite, PCSrc, RD);
							$display(" WD[%d] = %b, (%b expected)", i, WD[i], WD_expected[i]);
						
							errors = errors + 1;
						end
					 end
				end
				assert (overflow === overflow_expected) else 
					 begin
						if(overflow_expected !== 1'bx) begin
							$display("Line with error: %1d", vectornum + 1);
							$display("Error: ck: %b, reset_: %b, IorD: %b, IRWrite: %b,", ck, reset_, IorD, IRWrite); 
							$display(" RegDest: %b, MemtoReg: %b, RegWrite: %b,", RegDest, MemtoReg, RegWrite);
							$display(" ALUSrcA: %b, ALUSrcB: %b, ALUControl: %b,", ALUSrcA, ALUSrcB, ALUControl);
							$display(" Branch: %b, PCWrite: %b, PCSrc: %b, RD: %b", Branch, PCWrite, PCSrc, RD);
							$display(" overflow = %b, (%b expected)", overflow, overflow_expected);
						
							errors = errors + 1;
						end
					 end
				
				vectornum = vectornum + 1;
				
				if(testvectors[vectornum] === 114'bx) begin
					$display("%d tests completed with %d errors", vectornum, errors);
					$finish;
				end
			end
endmodule
