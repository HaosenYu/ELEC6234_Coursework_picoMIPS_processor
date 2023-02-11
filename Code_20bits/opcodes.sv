//-------------------------------------------------------------------------------
//** Part       : ELEC6234_CourseWork01
//** File name  : opcodes.sv
//** Description: opcodes for decoder.
//** Author     : Haosen Yu
//** Email      : haosenyu@hotmail.com or hy3u21@soton.ac.uk
//** Revision   : Version 1.0
//**            : Version 1.0 contains 9 funcs: Haosen Yu, 16/04/2022
//** Date       : 16/04/2022 12:00:00
//-------------------------------------------------------------------------------
// No operation (ADDI %0, %0, 0)
`define NOP    6'b111111
// ADD %d, %s;  %d = %d + %s
`define ADD    6'b000000
// ADDI %d, %s, imm;  %d = %s + imm
`define ADDI   6'b000001
// SUB %d, %s;  %d = %d - %s
`define SUB    6'b000010
// SUBI %d, %s, imm;  %d = %s - imm
`define SUBI   6'b000011
// MUL %d, %s;  %d = %d * %s
`define MUL    6'b000100
// MULI %d, %s, imm;  %d = %s * imm
`define MULI   6'b000101
// ADDF %d, %s, imm;  %d = %s + inport imm
`define ADDF   6'b000110
//branch at specified conditions (Bstus==I[7])
`define BAT    6'b000111
// SHOW %d, %0;  output display <= %d
 `define SHOW   6'b001000
// branch if %d == %s
//`define BEQ    6'b001000
// branch if %d != %s
//`define BNE    6'b001001
// branch if %d >= %s
//`define BGE    6'b001010
// branch if %d < %s
//`define BLT    6'b001011