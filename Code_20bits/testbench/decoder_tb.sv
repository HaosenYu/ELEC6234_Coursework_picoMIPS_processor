//-------------------------------------------------------------------------------
//** Part       : ELEC6234_CourseWork01
//** File name  : decoder_tb.sv
//** Description: testbench for picoMIPS instruction decoder.
//** Author     : Haosen Yu
//** Email      : haosenyu@hotmail.com or hy3u21@soton.ac.uk
//** Revision   : Version 1.0
//**            : Version 1.0 is based on tjk's work, only NOP, ADD, ADDI: 26/10/2012
//** Date       : 17/04/2022 12:00:00
//-------------------------------------------------------------------------------
`include "opcodes.sv"
//------------------------------------------------
module decoder_tb;

logic [5:0] opcode; // top 6 bits of instruction
logic [3:0] flags; // ALU flags V,N,Z,C
logic [2:0] ALUfunc; // ALU function
logic Bcond; // Branch condition
logic Bstus; // Branch status, connected to specified switch
// PC control, imm MUX control, register file control
logic PCincr, PCabsbranch, PCrelbranch, imm, fetch, w;

// create dec object
decoder dec (
        .opcode(opcode),
        .flags(flags),
        .Bcond(Bcond), // Branch condition
        .Bstus(Bstus),  // Branch status
        .PCincr(PCincr),
        .PCabsbranch(PCabsbranch),
        .PCrelbranch(PCrelbranch),
        .ALUfunc(ALUfunc),
        .imm(imm),
        .fetch(fetch),
        .w(w));
//------------------------------------------------
initial 
	begin // for 100ns
    Bcond = 1'b0; Bstus = 1'b1; // if Bstus == Bcond, hold status.
    flags = 4'b0;

		opcode = `NOP;  //opcode: NOP  -> 6'b111111
    #10ns opcode = `ADD;  //opcode: ADD  -> 6'b000000
		#10ns opcode = `ADDI; //opcode: ADDI -> 6'b000001
    #10ns opcode = `ADDF; //opcode: ADDF -> 6'b000110
    #10ns opcode = `SUB;  //opcode: SUB  -> 6'b000010
    #10ns opcode = `SUBI; //opcode: SUBI -> 6'b000011
    #10ns opcode = `MUL;  //opcode: MUL  -> 6'b000100
		#10ns opcode = `MULI; //opcode: MULI -> 6'b000101
		#10ns opcode = `BAT;  //opcode: BAT  -> 6'b000111
    #10ns Bstus = 1'b0; opcode = `BAT;
	end 

endmodule // end of module decoder_tb