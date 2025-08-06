/*----------------------------------------------------------*/
/* 																			*/
/* Module: Control Unit													*/
/*										 										*/
/* Inputs: isntr															*/
/* 																			*/
/* Outputs: Branch, MemtoReg, MemWritem ReadMem, ALUSrc,		*/
/* 			RegWrite, immSrc, branch_src							*/
/* 																			*/
/* The purpose of this module is to asynchronously 			*/
/*	distribute the control signals across the processor when */
/* each time the Program Counter is updated.						*/
/* 																			*/
/*----------------------------------------------------------*/

module Control(
  input [4:0] instr,
  output logic Branch, MemtoReg, MemWrite, ReadMem,
  output logic ALUSrc, RegWrite, immSrc,
  output logic [3:0] ALUOp,
  output logic [1:0] branch_src
);
  
always_comb begin
  Branch 	=  'b0;
  MemWrite  =	'b0;
  ReadMem   =  'b0;
  ALUSrc 	=	'b0;
  RegWrite  =	'b0;
  MemtoReg  =	'b0;
  immSrc    =  'b0;
  ALUOp	   =  'b1111; // y = 0;
  branch_src=  'b11;
casez(instr)
  5'b10000:  begin
               RegWrite = 'b1;
					ALUOp = 4'b0000;
			 end
  5'b10001:  begin
               RegWrite = 'b1;
					ALUOp = 4'b0001;
			 end
  5'b10010:  begin
               RegWrite = 'b1;
					ALUOp = 4'b0010;
			 end
  5'b10011:  begin
               RegWrite = 'b1;
					ALUOp = 4'b0011;
			 end
  5'b10100:  begin
               RegWrite = 'b1;
					ALUOp = 4'b0100;
			 end
  5'b10101:  begin
               RegWrite = 'b1;
					ALUOp = 4'b0101;
			 end
  5'b10110:	   ALUOp = 4'b0110;
  5'b10111:  begin
               ALUSrc = 'b1;
					ALUOp = 4'b0111;
			 end
  5'b11000:  begin
               RegWrite = 'b1;
					ALUOp = 4'b1000;
			 end
  5'b11001:  begin
               RegWrite = 'b1;
					ALUSrc = 'b1;
					ALUOp = 4'b1001;
			 end
  5'b11010:  begin
					MemtoReg = 'b1;
					ReadMem = 'b1;
               RegWrite = 'b1;
					ALUOp = 4'b1010;
			 end
  5'b11011:  begin
               MemWrite = 'b1;
					ALUOp = 4'b1011;
			 end
  5'b11100:  begin
               RegWrite = 'b1;
					ALUSrc = 'b1;
					ALUOp = 4'b1100;
			 end
  5'b11101:  begin
               RegWrite = 'b1;
					ALUSrc = 'b1;
					ALUOp = 4'b1101;
			 end
  5'b11110:  begin
               RegWrite = 'b1;
					ALUOp = 4'b1110;
			 end
  5'b11111:  begin
               RegWrite = 'b1;
					ALUOp = 4'b1111;
			 end
  5'b000??: begin
		Branch = 'b1;
		immSrc = 'b1;
		branch_src = 2'b10;
  end
  
  5'b001??: begin
		Branch = 'b1;
		immSrc = 'b1;
		branch_src = 2'b11; //TODO (bl)
  end
  
  5'b010??: begin
		Branch = 'b1;
		immSrc = 'b1;
		branch_src = 2'b00;
  end
  
  5'b011??: begin
		Branch = 'b1;
		immSrc = 'b1;
		branch_src = 2'b01;
  end
  
  default: ALUOp = 4'b1111;
endcase
end
endmodule
