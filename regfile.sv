module regfile (
  input  logic i_clk,
  input  logic [4:0] i_rs1_addr, i_rs2_addr,
  input  logic [4:0] i_rd_addr, 
  input  logic [31:0] i_rd_data,
  input  logic i_rd_wren,
  output logic [31:0] o_rs1_data, o_rs2_data
);
  logic [31:0] register_rf [31:0];
  assign o_rs1_data = (i_rs1_addr != 5'b0) ? register_rf[i_rs1_addr] : 32'b0;
  assign o_rs2_data = (i_rs2_addr != 5'b0) ? register_rf[i_rs2_addr] : 32'b0;
  always_ff @(posedge i_clk) begin
    if (i_rd_wren)
	   register_rf[i_rd_addr] <= i_rd_data;
  end
endmodule