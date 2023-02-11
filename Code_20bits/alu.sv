//-------------------------------------------------------------------------------
//** Part       : ELEC6234_CourseWork01
//** File name  : alu.sv
//** Description: ALU module for picoMIPS.
//** Author     : Haosen Yu
//** Email      : haosenyu@hotmail.com or hy3u21@soton.ac.uk
//** Revision   : Version 1.0
//**            : Version 1.0 is based on tjk's work, only 8 funcs: 23/10/2012
//** Date       : 16/04/2022 12:00:00
//-------------------------------------------------------------------------------
`include "alucodes.sv"
//------------------------------------------------
module alu #(parameter n = 8)
(input logic [n-1:0] a, b, // ALU operands
 input logic [2:0] func, // ALU function code
 output logic [3:0] flags, // ALU flags N,Z,C,V
 output logic [n-1:0] result // ALU result
);       
//------------------------------------------------
// create an n-bit adder 
// and then build the ALU around the adder
logic[n-1:0] ar,b1; // temp signals
logic[(2*n)-1:0] mr; // temp signals
always_comb
begin
   if(func==`RSUB)
      b1 = ~b + 1'b1; // 2's complement subtrahend
   else
      b1 = b;
   //Generate results
   ar = a + b1; // n-bit adder
end
   
// create the ALU, use signal ar in arithmetic operations
always_comb
begin
   //default output values; prevent latches 
   flags = 4'b0;
   mr = 0;
   result = a; // default
   case(func)
      `RNOP  : ;
      `RADD  : begin
                  result = ar; // arithmetic addition
                  // V: Set value to 1 if overflowed
                  flags[0] = a[7] & b[7] & ~result[7] | ~a[7] & ~b[7] & result[7];
                  // C: Set value to 1 if carried out
                  flags[1] = a[7] & b[7] | a[7] & ~result[7] | b[7] & ~result[7];
               end
      `RSUB  : begin
                  result = ar; // arithmetic subtraction
                  // V
                  flags[0] = ~a[7] & b[7] & ~result[7] | a[7] & ~b[7] & result[7];
                  // C - note: picoMIPS inverts carry when subtracting
                  flags[1] = a[7] & ~b[7] | a[7] & result[7] | ~b[7] & result[7];
               end
      `RMUL  : begin
                  mr = {{n{a[7]}}, a[7:0]} * {{n{b[7]}}, b[7:0]};
                  /*
                  booth_top u_booth_top(
                     .A({{n{a[7]}}, a[7:0]}), 
                     .B({{n{b[7]}}, b[7:0]}), 
                     .P(mr)); // use Radix-4 Booth Multiplier.
                  */
                  result = mr[14:7]; // mr[(2*n)-2:n-1];
                  // V
                  flags[0] = (~a[7] & ~b[7] & result[7]) | (~a[7] & b[7] & ~result[7]) |
                   (a[7] & ~b[7] & ~result[7]) | (a[7] & b[7] & result[7]);
                  // C
                  //flags[1] = 1'b0;
               end
      //`RA    : result = a;
      //`RB    : result = b;
      //`RAND  : result = a & b;
      //`ROR   : result = a | b;
      //`RXOR  : result = a ^ b;
      //`RNOR  : result = ~(a | b);
      default: ; // $error("unimplemented ALU function opcode: %h", func);
   endcase

   // calculate flags Z and N
   flags[2] = ar == {n{1'b0}}; // Z: Set value to 1 if equal
   flags[3] = result[n-1]; // N: Set value to 1 if negative
end

endmodule //end of module alu