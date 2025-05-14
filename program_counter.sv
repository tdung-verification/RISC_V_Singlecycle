module program_counter (
  input  logic i_clk, i_rst,
  input  logic [31:0] i_nextpc,
  output logic [31:0] o_pc
);
  always_ff @(posedge i_clk) begin : pc_ff
    if (i_rst)
	   o_pc <= 32'b0;
	 else o_pc <= i_nextpc;
  end
endmodule