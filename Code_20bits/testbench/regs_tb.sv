//-------------------------------------------------------------------------------
//** Part       : ELEC6234_CourseWork01
//** File name  : regs_tb.sv
//** Description: testbench for pMIPS 32 x n registers, %0 == 0.
//** Author     : Haosen Yu
//** Email      : haosenyu@hotmail.com or hy3u21@soton.ac.uk
//** Revision   : Version 1.0
//**            : Version 1.0 is based on tjk's work, only NOP, ADD, ADDI: 25/10/2012
//**            : code template for Cyclone  MLAB and true dual port sync RAM.
//** Date       : 17/04/2022 12:00:00
//-------------------------------------------------------------------------------
module regs_tb;

parameter n = 8;

logic clk, w;
logic [n-1:0] Wdata;
logic [2:0] Raddr1, Raddr2;
logic [n-1:0] Rdata1, Rdata2;

// create regs object
regs #(.n(n)) u_reg (.*);
//------------------------------------------------
initial
begin // for 50ns
  clk = 1'b0;
  forever #5ns clk = ~clk;
end

initial
begin
  w = 1'b0;
  Wdata = 8'b00000111;
  Raddr1 = 3'b001; Raddr2 = 3'b000;

  #10ns Raddr1 = 3'b000; Raddr2 = 3'b010;

  // test write 0 to dest reg (Raddr2)
  #10ns w = 1'b1;
  @(posedge clk);
  #10ns w = 1'b1; Wdata = 8'b00000000;
  @(posedge clk);
end

endmodule // end of module regs_tb