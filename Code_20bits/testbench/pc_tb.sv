//-------------------------------------------------------------------------------
//** Part       : ELEC6234_CourseWork01
//** File name  : pc_tb.sv
//** Description: testbench for picoMIPS program counter.
//** Author     : Haosen Yu
//** Email      : haosenyu@hotmail.com or hy3u21@soton.ac.uk
//** Revision   : Version 1.0
//**            : Version 1.0 includes a test for increment or branch.
//** Date       : 17/04/2022 12:00:00
//-------------------------------------------------------------------------------
module pc_tb;

parameter Psize = 5;

logic clk;
logic nreset;
logic PCincr, PCabsbranch, PCrelbranch;
logic [Psize-1:0] Branchaddr;
logic [Psize-1:0] Rbranch;
logic [Psize-1:0] PCout;

// create pc object 
pc #(.Psize(Psize)) pc (
	.clk(clk), 
	.nreset(nreset), 
	.PCincr(PCincr), 
	.PCabsbranch(PCabsbranch),
    .PCrelbranch(PCrelbranch),
	.Branchaddr(Branchaddr),
	.PCout(PCout));
//------------------------------------------------
initial 
begin 
	clk = 1'b0;
	forever #5ns clk = ~clk;
end

initial 
begin // for 50ns
	nreset = 1'b0; 
	PCincr = 1'b0; PCabsbranch = 1'b0; PCrelbranch = 1'b0;
	Branchaddr = 5'b00000;

	// test pc increment
	#10ns nreset = 1'b1; 
	PCincr = 1'b1;
	
	// test pc relative branch
	#10ns PCincr = 1'b0; 
	PCrelbranch = 1'b1; 
	Branchaddr = 5'b00011;

	// test pc absolute branch
	#10ns PCrelbranch = 1'b0;
	PCabsbranch = 1'b1; 
	Branchaddr = 5'b00010;

	// reset
	#10ns nreset = 1'b0; 
end 
endmodule // end of module pc_tb