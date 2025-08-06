/*----------------------------------------------------------*/
/* 																			*/
/* Module: ALU						 										*/
/* Input: OpCode, inA, inB	     										*/
/* Output: Result, neg, flag	 										*/
/* 																			*/
/* The purpose of this module is to process 8-bit data.     */
/* The inB port is able to receive an immediate value, or a */
/* value from the Register File.     								*/
/* ALU outputs 8-bit data, as well as flags that determine  */
/* if conditional branches should be taken.						*/
/* 																			*/
/*----------------------------------------------------------*/

module ALU(
  input [3:0] OP,
  input [7:0] inA,
  input [7:0] inB,
  output logic [7:0] rslt,
  output logic neg, zero);
  
  logic signed [7:0] signed_asr;
	
  always_comb begin
	  neg = '0;
	  zero = '0;
	  rslt = '0;
	  signed_asr = '0;
	  
	  case(OP)
	  4'b0000: begin // add rs1, rs1, rs2
		  rslt = inA + inB;
	  end
	  
	  4'b0001: begin // sub rs1, rs1, rs2
		  rslt = inA - inB;
	  end
	  
	  4'b0010: begin // and rs1, rs1, rs2
		  rslt = inA & inB;
	  end
	  
	  4'b0011: begin // orr rs1, rs1, rs2
		  rslt = inA | inB;
	  end
	  
	  4'b0100: begin // lsl rs1, rs1, rs2
		  rslt = inA << inB;
	  end
	  
	  4'b0101: begin // asr rs1, rs1, rs2
		  signed_asr = inA;
		  rslt = signed_asr >>> inB;
	  end
	  
	  4'b0110: begin // sends flags given comparison
		  if(inA<inB) neg = 1'b1;
		  else if (inA==inB) zero = 1'b1;
	  end
	  
	  4'b0111: begin // sends flags given comparison (immediate)
		  if(inA<inB) neg = 1'b1;
		  else if (inA==inB) zero = 1'b1;
	  end
	  
	  4'b1000: begin // mov rs1, rs2
		  rslt = inB;
	  end
	  
	  4'b1001: begin // mvi rs1, #2
		  rslt = inB;
	  end
	  
	  4'b1010: begin // ldr rs1, rs2
		  rslt = inB;
	  end
	  
	  4'b1011: begin // str rs1, rs2
		  rslt = inB;
	  end
	  
	  4'b1100: begin // lsi rs1, rs1, #2
		  rslt = inA<<inB;
	  end
	  
	  4'b1101: begin // ori rs1, rs1, #2
		  rslt = inA | inB;
	  end
	  
	  4'b1110: begin // xor rs1, rs1, r2
		  rslt = inA ^ inB;
	  end
	  
	  4'b1111: begin //lsr rs1, rs1, rs2
		  rslt = inA>>inB;
	  end
	  
	  default: begin
			rslt = '0;
	  end
	  endcase
  end

endmodule
