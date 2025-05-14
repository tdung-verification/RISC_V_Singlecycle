module control_unit (
  input  logic [31:0] i_inst,
  input  logic i_br_less, i_br_equal,
  output logic o_inst_vld,
  output logic o_rd_wren, o_br_un, o_lsu_wren,
  output logic o_pc_sel, o_opa_sel, o_opb_sel, 
  output logic [1:0] o_wb_sel,
  output logic [3:0] o_alu_op
);
  logic [6:0] opcode;
  logic [2:0] funct3;
  logic       funct7;
  logic [1:0] alu_dec;
  assign opcode = i_inst[6:0];
  assign funct3 = i_inst[14:12];
  assign funct7 = i_inst[30];
  always_comb begin
    o_inst_vld = 1'b1;
    case(opcode)
	   7'b0110011: begin //r-type
		  o_pc_sel   = 1'b0 ;
		  o_rd_wren  = 1'b1 ;
		  o_br_un    = 1'b0 ; //tuy dinh
		  o_opa_sel  = 1'b0 ;
		  o_opb_sel  = 1'b0 ;
		  alu_dec    = 2'b01;
		  o_lsu_wren = 1'b0 ;
		  o_wb_sel   = 2'b01 ;
		  end
	   7'b0010011: begin //I-type
		  o_pc_sel   = 1'b0 ;
		  o_rd_wren  = 1'b1 ;
		  o_br_un    = 1'b0 ; //tuy dinh
		  o_opa_sel  = 1'b0 ;
		  o_opb_sel  = 1'b1 ;
		  alu_dec    = 2'b01;
		  o_lsu_wren = 1'b0 ;
		  o_wb_sel   = 2'b01 ;
		  end
	   7'b0000011: begin //load-type
		  o_pc_sel   = 1'b0 ;
		  o_rd_wren  = 1'b1 ;
		  o_br_un    = 1'b0 ; //tuy dinh
		  o_opa_sel  = 1'b0 ;
		  o_opb_sel  = 1'b1 ;
		  alu_dec    = 2'b00;
		  o_lsu_wren = 1'b0 ;
		  o_wb_sel   = 2'b00 ;
		  end
	   7'b0100011: begin //S-type
		  o_pc_sel   = 1'b0 ;
		  o_rd_wren  = 1'b0 ;
		  o_br_un    = 1'b0 ; //tuy dinh
		  o_opa_sel  = 1'b0 ;
		  o_opb_sel  = 1'b1 ;
		  alu_dec    = 2'b00;
		  o_lsu_wren = 1'b1 ;
		  o_wb_sel   = 2'b01 ; //tuy dinh
		  end
	   7'b1100011: begin //B-type
		  case(funct3)
		    3'b000:begin //BEQ
			   o_br_un  = 1'b0;
			   o_pc_sel = (i_br_equal == 1'b1) ? 1'b1 : 1'b0;
			   end
			 3'b001: begin //BNE
			   o_br_un  = 1'b0;
			   o_pc_sel = (i_br_equal == 1'b0) ? 1'b1 : 1'b0;
			   end
			 3'b100: begin //BLT
			   o_br_un  = 1'b0;
			   o_pc_sel = (i_br_less == 1'b1) ? 1'b1 : 1'b0;
			   end
			 3'b101: begin  //BGE
			   o_br_un  = 1'b0;
			   o_pc_sel = (i_br_less == 1'b0) ? 1'b1 : 1'b0;
			   end
			 3'b110: begin  //BLTU
			   o_br_un  = 1'b1;
			   o_pc_sel = (i_br_less == 1'b1) ? 1'b1 : 1'b0;
			   end
			 3'b111: begin  //BGEU
			   o_br_un  = 1'b1;
			   o_pc_sel = (i_br_less == 1'b0) ? 1'b1 : 1'b0;
			   end
			 default: begin
			   o_br_un  = 1'b0;
			   o_pc_sel = 1'b0;
				o_inst_vld=1'b0;
			   end
		  endcase
		  o_rd_wren  = 1'b0 ;
		  o_opa_sel  = 1'b1 ;
		  o_opb_sel  = 1'b1 ;
		  alu_dec    = 2'b00;
		  o_lsu_wren = 1'b0 ;
		  o_wb_sel   = 2'b01 ; //tuy dinh
		  end
	   7'b1101111: begin  //J-type
		  o_pc_sel   = 1'b1 ;
		  o_rd_wren  = 1'b1 ;
		  o_br_un    = 1'b0 ; //tuy dinh
		  o_opa_sel  = 1'b1 ;
		  o_opb_sel  = 1'b1 ;
		  alu_dec    = 2'b00;
		  o_lsu_wren = 1'b0 ;
		  o_wb_sel   = 2'b10;
		  end
	   7'b0110111: begin  // lui
		  o_pc_sel   = 1'b0 ;
		  o_rd_wren  = 1'b1 ;
		  o_br_un    = 1'b0 ; //tuy dinh
		  o_opa_sel  = 1'b0 ; //tuy dinh
		  o_opb_sel  = 1'b1 ;
		  alu_dec    = 2'b10;
		  o_lsu_wren = 1'b0 ;
		  o_wb_sel   = 2'b01;
		  end
	   7'b0010111: begin  // auipc
		  o_pc_sel   = 1'b0 ;
		  o_rd_wren  = 1'b1 ;
		  o_br_un    = 1'b0 ; //tuy dinh
		  o_opa_sel  = 1'b1 ; 
		  o_opb_sel  = 1'b1 ;
		  alu_dec    = 2'b00;
		  o_lsu_wren = 1'b0 ;
		  o_wb_sel   = 2'b01;
		  end
	   7'b1100111: begin  // jalr
		  o_pc_sel   = 1'b1 ;
		  o_rd_wren  = 1'b1 ;
		  o_br_un    = 1'b0 ; //tuy dinh
		  o_opa_sel  = 1'b0 ; 
		  o_opb_sel  = 1'b1 ;
		  alu_dec    = 2'b00;
		  o_lsu_wren = 1'b0 ;
		  o_wb_sel   = 2'b10;
		  end
		default: begin
		  o_pc_sel   = 1'b0 ;
		  o_rd_wren  = 1'b0 ;
		  o_br_un    = 1'b0 ; //tuy dinh
		  o_opa_sel  = 1'b0 ; 
		  o_opb_sel  = 1'b0 ;
		  alu_dec    = 2'b00;
		  o_lsu_wren = 1'b0 ;
		  o_wb_sel   = 2'b01;
		  o_inst_vld = 1'b0;
		  end
	 endcase
  end
// output alu_op
  alu_control alu_ctrl(
    .i_alu_dec(alu_dec),
    .i_funct3(funct3),
    .i_funct7(funct7),
	 .i_opcode5(i_inst[5]),
    .o_alu_op(o_alu_op)
  );
endmodule