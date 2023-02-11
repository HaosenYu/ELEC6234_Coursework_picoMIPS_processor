//-------------------------------------------------------------------------------
//** Part       : ELEC6234_CourseWork01
//** File name  : prog.sv
//** Description: Program memory Psize x Isize - reads from file prog.hex.
//** Author     : Haosen Yu
//** Email      : haosenyu@hotmail.com or hy3u21@soton.ac.uk
//** Revision   : Version 1.0
//**            : Version 1.0 is based on tjk's work: 24/10/2012
//** Date       : 16/04/2022 12:00:00
//-------------------------------------------------------------------------------
module prog #(parameter Psize = 5, Isize = 20) // psize - address width, Isize - instruction width
(input logic [Psize-1:0] address,
 output logic [Isize-1:0] I  // I - instruction code
);
//------------------------------------------------
// program memory declaration, note: 1<<n is same as 2^n
logic [Isize-1:0] progMem [(1<<Psize)-1:0];

// get memory contents from file
initial
  $readmemh("prog20.hex", progMem);
  
// program memory read 
always_comb
  I = progMem[address];
  
endmodule // end of module prog
