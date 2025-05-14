module singlecycle(
  input  logic i_clk, i_rst_n,
  input  logic [31:0] i_io_sw,
  output logic [31:0] o_io_ledr, o_io_ledg,
  output logic o_insn_vld,
  output logic [31:0] o_pc_debug,
  output logic [31:0] o_alu_datatest,
  output logic [31:0] o_operanda_test, o_operandb_test,
  output logic [31:0] alu_data,
  output logic [31:0] ld_data
);
  logic rd_wren, br_un, lsu_wren, pc_sel, opa_sel, opb_sel;
  logic [1:0] wb_sel;
  logic [3:0] alu_op;
  logic [31:0] nextpc, pc_now;
  logic [31:0] inst_temp;
  logic [31:0] rs1_data, rs2_data;
  logic [31:0] imm;
  logic [31:0] operand_a, operand_b;
  logic br_less_temp, br_equal_temp;

  logic [31:0] pc_four, wb_data_temp;
  control_unit ctrlunit(
    .i_inst(inst_temp),
    .i_br_less(br_less_temp),
	 .i_br_equal(br_equal_temp),
    .o_inst_vld(o_insn_vld),
    .o_rd_wren(rd_wren),
	 .o_br_un(br_un),
	 .o_lsu_wren(lsu_wren),
    .o_pc_sel(pc_sel),
	 .o_opa_sel(opa_sel),
	 .o_opb_sel(opb_sel), 
    .o_wb_sel(wb_sel),
    .o_alu_op(alu_op)
  );
  
 
  program_counter pc_ff(
    .i_clk(i_clk),
	 .i_rst(~i_rst_n),
    .i_nextpc(nextpc),
    .o_pc(pc_now)
  );
  

  instmemory imem(
    .addr(pc_now),
    .rdata(inst_temp)
  );
  

  regfile register(
    .i_clk(i_clk),
    .i_rst(~i_rst_n),
    .i_rs1_addr(inst_temp[19:15]),
	 .i_rs2_addr(inst_temp[24:20]),
    .i_rd_addr(inst_temp[11:7]),
	 .i_rd_data(wb_data_temp),
    .i_rd_wren(rd_wren),
    .o_rs1_data(rs1_data),
	 .o_rs2_data(rs2_data)
  );
  

  immgen immediately(
    .i_inst(inst_temp),
    .o_imm(imm)
  );
  

  branch_comb branches(
    .i_rs1_data(rs1_data),
	 .i_rs2_data(rs2_data),
    .i_br_un(br_un),
    .o_br_less(br_less_temp),
	 .o_br_equal(br_equal_temp)
  );
  

  assign operand_a = (opa_sel == 1'b1) ? pc_now  : rs1_data;
  assign operand_b = (opb_sel == 1'b1) ? imm     : rs2_data;
  

  alu alu_unit(
    .i_operand_a(operand_a),
	 .i_operand_b(operand_b),
    .i_alu_op(alu_op),
    .o_alu_data(alu_data)
  );
  

  lsu dmem(
    .i_clk(i_clk),
	 .i_rst(!i_rst_n),
    .i_lsu_addr(alu_data),
	 .i_st_data(rs2_data),
    .i_lsu_wren(lsu_wren),
    .i_io_sw(i_io_sw),
    .o_ld_data(ld_data),
	 .o_io_ledr(o_io_ledr),
	 .o_io_ledg(o_io_ledg)
  );
  

  assign pc_four = pc_now + 32'd4;
  mux3to1 mux3(
    .a(ld_data),
	 .b(alu_data),
	 .c(pc_four),
    .sel(wb_sel),
    .y(wb_data_temp)
  );
  
  assign nextpc = (pc_sel) ? alu_data : pc_four;
  assign o_pc_debug = pc_now;
  assign o_alu_datatest = alu_data;
  assign o_operanda_test = operand_a;
  assign o_operandb_test = operand_b;
endmodule