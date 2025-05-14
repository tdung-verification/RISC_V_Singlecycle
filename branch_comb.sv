module branch_comb (
  input  logic [31:0] i_rs1_data, i_rs2_data,
  input  logic i_br_un,
  output logic o_br_less, o_br_equal
);
  logic [31:0] sub_result;
  logic [32:0] sub_result_unsign;
  logic overflow;
  logic sign_a, sign_b, sign_sub_result, borrow_bit;

  assign sub_result = i_rs1_data + (~i_rs2_data) +32'b1;
  assign sub_result_unsign = {1'b1,i_rs1_data} + (~{1'b0,i_rs2_data}) +33'b1;
  // lay dau
  assign sign_a = i_rs1_data[31];
  assign sign_b = i_rs2_data[31];
  assign sign_sub_result = sub_result[31];
  assign borrow_bit = sub_result_unsign[31];
  //
  assign overflow = (sign_a & ~sign_b & ~sign_sub_result) | (~sign_a & sign_b & sign_sub_result);
  
  //output combinational
  assign o_br_equal = (sub_result == 32'b0) ? 1'b1 : 1'b0; 
  always_comb begin
    if (!i_br_un)
	   o_br_less = (sign_sub_result ^ overflow) ? 1'b1 : 1'b0;
	 else
	   o_br_less = (borrow_bit == 1'b1) ? 1'b0 : 1'b1;
  end
endmodule