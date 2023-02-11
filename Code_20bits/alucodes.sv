//-------------------------------------------------------------------------------
//** Part       : ELEC6234_CourseWork01
//** File name  : alucodes.sv
//** Description: pMIPS ALU funcRon code definiRons.
//** Author     : Haosen Yu
//** Email      : haosenyu@hotmail.com or hy3u21@soton.ac.uk
//** Revision   : Version 1.0
//**            : Version 1.0 contains RADD,RSUB,RMUL 3 funcs: Haosen Yu, 16/04/2022
//** Date       : 16/04/2022 12:00:00
//-------------------------------------------------------------------------------
`define RNOP    3'b111
`define RADD    3'b000
`define RSUB    3'b001
`define RMUL    3'b010
//`define RAND    3'b011
//`define ROR     3'b100
//`define RXOR    3'b101
//`define RNOR    3'b110