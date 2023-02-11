//-------------------------------------------------------------------------------
//** Part       : ELEC6234_CourseWork01
//** File name  : pc.sv
//** Description: picoMIPS Program Counter.
//** Author     : Haosen Yu
//** Email      : haosenyu@hotmail.com or hy3u21@soton.ac.uk
//** Revision   : Version 1.0
//**            : Version 1.0 is based on tjk's work: 24/10/2012
//**            : Version 1.0 includes increment, absolute and relative branches.
//** Date       : 16/04/2022 12:00:00
//-------------------------------------------------------------------------------
module pc #(parameter Psize = 5) // up to 32 instructions
(input logic clk, nreset, PCincr, PCabsbranch, PCrelbranch,
 input logic [Psize-1:0] Branchaddr,
 output logic [Psize-1:0] PCout
);
//------------------------------------------------
logic[Psize-1:0] Rbranch; // temp variable for addition operand
always_comb
  if (PCincr)
      Rbranch = {{(Psize-1){1'b0}}, 1'b1};
  else
      Rbranch =  Branchaddr;

always_ff @(posedge clk or negedge nreset) // async reset
   if (!nreset) // sync reset
      PCout <= {Psize{1'b0}};
   else if (PCincr | PCrelbranch) // increment or relative branch
      PCout <= PCout + Rbranch; // 1 adder does both
   else if (PCabsbranch) // absolute branch
      PCout <= Branchaddr;
	 
endmodule // end of module pc