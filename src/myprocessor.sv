/*----------------------------------------------------------*/
/* 																			*/
/* Module: Top Level														*/
/*										 										*/
/* Inputs: Clock, Start, Reset										*/
/* 																			*/
/* Outputs: Done															*/
/* 																			*/
/*----------------------------------------------------------*/

module myprocessor(
  input        clk,
  input			start,
  input        reset, 
  output logic done
);
parameter D = 8, A = 4;
parameter HALT_PC = 140;

wire [D-1:0] prog_ctr, datA, datB, muxB;
wire [D-1:0] rslt, immed, memData, writeback;
logic       pariQ, zeroQ;
wire        RegWrite, MemtoReg, immSrc;
wire        relj, parity, zero, eq, lt, MemWrite, ALUSrc;
wire 			ReadMem, reljump_en;
wire [1:0]  branch_src;
wire [A-1:0] alu_cmd;
wire [8:0]  mach_code;
wire [1:0]  rd_addrA, rd_addrB;

// PC instantiation, 8-bit program counter for now.
// because every other data field is 8-bits, so its easier
// for testing
PC #(.D(D)) pc1(
  .reset,
  .clk,
  .reljump_en,
  .enable(start),
  .target(immed),
  .prog_ctr
);

// contains machine code
  InstROM19 ir1(.prog_ctr(prog_ctr),
               .mach_code(mach_code));

// control decoder, still under construction
  Control ctl1(.instr(mach_code[8:4]),
  .Branch(relj),     
  .MemtoReg,
  .MemWrite,
  .ReadMem,
  .ALUSrc, 
  .RegWrite,
  .immSrc,
  .ALUOp(alu_cmd),
  .branch_src);
  
  // Sign extend immediates
  sign_extend imm(.data_in(mach_code[5:0]),
						.immSrc,
						.extended(immed));

  assign rd_addrA = mach_code[3:2];
  assign rd_addrB = mach_code[1:0];


  
  reg_file #(.pw(2)) rf1(.dat_in(writeback),  // writeback will come from ALU or DataMem
              .clk,
              .wr_en(RegWrite),
              .rd_addrA,
              .rd_addrB,
              .wr_addr(rd_addrA),
              .datA_out(datA),
              .datB_out(datB));

  assign muxB = ALUSrc? immed : datB;

// alu_cmd signal connects the Control --> ALU
// this allows my 9-bit instruction to dictate the behavior of the ALU
  ALU alu1(
	.OP(alu_cmd),
	.inA(datA),
	.inB(muxB),
	.rslt(rslt),
	.neg(parity),
	.zero(zero)
	);
	

	assign eq = zeroQ & relj;
	assign lt = pariQ & relj;
	assign reljump_en = (branch_src == 2'b00) ? eq :
                       (branch_src == 2'b01) ? lt :
                       (branch_src == 2'b10) ? 1'b1 : 1'b0;
							  

// Data Memory
  data_mem dm1(.clk,
				  .dataAddr(rslt),
				  .ReadMem,
				  .writeMem(MemWrite),
				  .dataIn(datA),
              .dataOut(memData));

  assign writeback = MemtoReg? memData : rslt;

				  
// registered flags from ALU
  always_ff @(posedge clk) begin
    pariQ <= parity;
	 zeroQ <= zero;
  end

  assign done = (prog_ctr == HALT_PC);
 
endmodule
