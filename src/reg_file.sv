/*----------------------------------------------------------*/
/* 																			*/
/* Module: Register File												*/
/*										 										*/
/* Inputs: Clock, WriteEnable, DataIn, rd_addrA, rd_addrB,	*/
/*			 WriteAddress													*/
/* 																			*/
/* Outputs: datAout, datBout											*/
/* 																			*/
/* The purpose of this module is to read from, or write to,	*/
/* the four available general purpose registers. If wr_en   */
/* is high then dat_in will be written to wr_addr.          */
/* Synchronous write and asynchronous read from registers.  */
/* 																			*/
/*----------------------------------------------------------*/

module reg_file #(
  parameter dw = 8,
            pw = 2
)(
  input  logic              clk,
  input  logic              wr_en,
  input  logic [dw-1:0]     dat_in,     // write data
  input  logic [pw-1:0]     rd_addrA,   // read address A
  input  logic [pw-1:0]     rd_addrB,   // read address B
  input  logic [pw-1:0]     wr_addr,    // write address
  output logic [dw-1:0]     datA_out,   // output A
  output logic [dw-1:0]     datB_out    // output B
);

  logic [dw-1:0] registers [0:3];

  // synchronous write
  always_ff @(posedge clk) begin
    if (wr_en)
      registers[wr_addr] <= dat_in;
  end

  // asynchronous read
  always_comb begin
    datA_out = registers[rd_addrA];
    datB_out = registers[rd_addrB];
  end

endmodule