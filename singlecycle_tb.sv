`timescale 1ns/1ps

module singlecycle_tb;
  // Clock and reset signals
  reg i_clk;
  reg i_rst_n;

  // Input and output signals
  reg [31:0] i_io_sw;
  wire [31:0] o_io_ledr, o_io_ledg;
  wire [31:0] alu_data, ld_data;

  // Instantiate the DUT (Device Under Test)
  singlecycle uut (
    .i_clk(i_clk),
    .i_rst_n(i_rst_n),
    .i_io_sw(i_io_sw),
    .o_io_ledr(o_io_ledr),
    .o_io_ledg(o_io_ledg),
	 .alu_data(alu_data),
	 .ld_data(ld_data)
  );

  // Clock generation
  initial begin
    i_clk = 0;
    forever #5 i_clk = ~i_clk; // 10 ns clock period
  end

  // Stimulus process
  initial begin
    // Initial values
    i_rst_n = 0;
    i_io_sw = 32'h00000000;

    // Apply reset
    #20;
    i_rst_n = 1;

    // Wait for a few clock cycles
    #100;

    // Test case 1: Basic instruction fetch
    i_io_sw = 32'hAAAAAAAA; // Example input for the switch
    #50;

    // Test case 2: Check output LED states
    i_io_sw = 32'h55555555;
    #50;

    // Test case 3: Simulate an instruction memory read
    // Add additional stimuli as needed for your design

    // Complete simulation
    #200;
    $stop;
  end

  // Optionally monitor signals for debugging
  initial begin
    $monitor($time, " clk=%b rst=%b sw=%h ledr=%h ledg=%h",
             i_clk, i_rst_n, i_io_sw, o_io_ledr, o_io_ledg);
  end

endmodule
