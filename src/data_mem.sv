/*----------------------------------------------------------*/
/*																				*/
/* Module: Data Memory 													*/
/* Inputs: Clock, ReadMem, WriteMem, DataAddress, DataIn    */
/* Output: 8-bit Data read from memory 							*/
/* 																			*/
/* The purpose of this module is to provide the ability to  */
/* read or write 8-bit data to Data Memory depending on the */
/* ReadMem/WriteMem signals.											*/
/* 																			*/
/* Data Memory has 256 entries that hold 8-bit data			*/
/*																				*/
/*----------------------------------------------------------*/

module data_mem(
  input              clk,
  input [7:0]        dataAddr,
  input              ReadMem,
  input              writeMem,
  input [7:0]       dataIn,
  output logic[7:0] dataOut);

  logic [7:0] my_memory [256];

//  initial 
//    $readmemh("dataram_init.list", my_memory);
  always_comb
    if(ReadMem) begin
      dataOut = my_memory[dataAddr];
	//  $display("Memory read M[%d] = %d",DataAddress,DataOut);
    end else 
      dataOut = 8'bZ;

  always_ff @ (posedge clk)
    if(writeMem) begin
      my_memory[dataAddr] = dataIn;
	//  $display("Memory write M[%d] = %d",DataAddress,DataIn);
    end
endmodule
