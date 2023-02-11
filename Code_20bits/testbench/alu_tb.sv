//-------------------------------------------------------------------------------
//** Part       : ELEC6234_CourseWork01
//** File name  : alu_tb.sv
//** Description: testbench for picoMIPS ALU.
//** Author     : Haosen Yu
//** Email      : haosenyu@hotmail.com or hy3u21@soton.ac.uk
//** Revision   : Version 1.0
//** Date       : 17/04/2022 12:00:00
//-------------------------------------------------------------------------------
`include "alucodes.sv"
//------------------------------------------------
module alu_tb;

parameter n = 8; // data bus width

logic [n-1:0] a, b; // ALU input operands   
logic [2:0] func; // ALU func code
logic [3:0] flags; // ALU flags N,Z,C,V
logic [n-1:0] result; // ALU result

// create alu object
alu #(.n(n)) alu1 (.a(a), .b(b), .func(func), .flags(flags), .result(result));
//------------------------------------------------
initial    
begin // for 30ns
	a = 8'h04;
	b = 8'h03; 
	func = `RADD;   // result = a + b
	#10ns func = `RSUB;   // result = a - b
	#10ns func = `RMUL;   // result = a * b
end
endmodule // end of module alu_tb