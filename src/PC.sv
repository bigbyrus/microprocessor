/*----------------------------------------------------------*/
/* 																			*/
/* Module: Program Counter												*/
/*										 										*/
/* Inputs: Reset, Clock, reljump_en, Enable, Target			*/
/* 																			*/
/* Outputs: prog_ctr														*/
/* 																			*/
/* The purpose of this module is to synchronously increment */
/* the Program Counter. When branching, reljump_en == 1 and */
/* the Program Counter will be incremented or decremented   */
/* based on the 6-bit 2's Complement "target" value.        */
/* 																			*/
/*----------------------------------------------------------*/

module PC #(parameter D=8)(
  input  logic            reset,
                          clk,
                          reljump_en,
                          enable,
  input  logic [D-1:0]    target,
  output logic [D-1:0]    prog_ctr
);

  logic signed [D-1:0] signed_target;
  logic started;

  always_comb begin
    signed_target = target;
  end

  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      prog_ctr <= '0;
      started  <= 0;
    end
    else begin
      // Latch the start signal once it goes high
      if (enable)
        started <= 1;

      if (started) begin
        if (reljump_en)
          prog_ctr <= prog_ctr + signed_target;
        else
          prog_ctr <= prog_ctr + 1;
      end
    end
  end

endmodule