`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/07/2023 09:46:20 PM
// Design Name: 
// Module Name: tb_ShiftAdd_Top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_ShiftAdd_Top;
  // Parameters
  parameter DATA_WIDTH_B = 18;
  parameter DATA_WIDTH_Q = 18;
  
  // Inputs
  reg clk;
  reg reset;
  reg [DATA_WIDTH_B-1:0] Multiplicand;
  reg [DATA_WIDTH_Q-1:0] Multiplier;
  
  // Outputs
  wire [DATA_WIDTH_B+DATA_WIDTH_Q-1:0] Product;
  wire halt;
  
  // Instantiate the module
  ShiftAdd_Top #(DATA_WIDTH_B,DATA_WIDTH_Q) dut (
    .clk(clk),
    .reset(reset),
    .Multiplicand(Multiplicand),
    .Multiplier(Multiplier),
    .Product(Product),
    .halt(halt)
  );

  // Signal to capture RegB value
  reg [DATA_WIDTH_B-1:0] RegB_tb;
  reg [DATA_WIDTH_B:0] RegA_tb;
  reg [DATA_WIDTH_Q-1:0] RegQ_tb;
  reg [DATA_WIDTH_B-1:0] Sum_tb;
  reg start_tb;
  reg shift_tb;
  reg write_tb;
  reg flag_tb;
  // Clock generation
  always begin
    #2; // Half the desired clock period
    clk = ~clk;
  end
  
  // Testbench logic
  initial begin
    clk = 0;
    reset = 1;
    Multiplicand = 12'ha6c; // Example input values
    Multiplier = 18'haa5b;
    reset = 0;
    #15;
    reset = 1;
  end
  
   always @(posedge clk) begin
    RegB_tb <= dut.RegB; // Capture RegB value at rising edge of clock
    RegA_tb <= dut.RegA;
    RegQ_tb <= dut.RegQ;
    Sum_tb <= dut.Sum;
    start_tb <= dut.start;
    shift_tb <= dut.shift;
    write_tb <= dut.write;
    flag_tb <= dut.flag;
  end

  // End simulation
  always @(posedge clk) begin
    #50000;
     $display("Multiplicand = %d, Multiplier = %d, RegB = %d, RegA = %d, RegQ = %d, Sum = %d, Product = %d, halt = %d, start = %d, shift = %d, write = %d, flag = %d",
              Multiplicand, Multiplier, RegB_tb, RegA_tb, RegQ_tb, Sum_tb, Product, halt, start_tb, shift_tb, write_tb, flag_tb,);
     $finish;
    end
endmodule
