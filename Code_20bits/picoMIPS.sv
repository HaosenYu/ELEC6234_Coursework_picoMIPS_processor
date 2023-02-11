//-------------------------------------------------------------------------------
//** Part       : ELEC6234_CourseWork01
//** File name  : picoMIPS.sv
//** Description: picoMIPS CPU top level encapsulating module.
//** Author     : Haosen Yu
//** Email      : haosenyu@hotmail.com or hy3u21@soton.ac.uk
//** Revision   : Version 1.0
//**            : Version 1.0 is based on tjk's V2.0 work: 27/10/2012
//**            : Version 1.0 includes PC,prog memory,regs,ALU and decoder,no RAM.
//** Date       : 16/04/2022 12:00:00
//-------------------------------------------------------------------------------
`include "alucodes.sv"
//------------------------------------------------
module picoMIPS #(parameter n = 8) // data bus width
(input  logic clk,  
 input  nreset, // master reset (active low)
 input  Bstus, // Branch status
 input  logic[n-1:0] x, // connected to switches
 output logic[n-1:0] outport // need an output port, tentatively this will be the ALU output
);       
//------------------------------------------------
// declarations of local signals that connect CPU modules
// ALU
logic [2:0] ALUfunc; // ALU function
logic [3:0] flags; // ALU flags N,Z,C,V, routed to decoder
logic [n-1:0] Alub; // output from imm MUX

//decoders
logic imm; // immediate operand signal
logic fetch; // fetch operand signal
logic show; // output display control

// registers
logic [n-1:0] Rdata1, Rdata2, Wdata; // Register data
logic w; // register write control

// Program Counter 
parameter Psize = 5; // up to 32 instructions
logic PCincr, PCabsbranch, PCrelbranch; // program counter control
logic [Psize-1:0] ProgAddress;

// Program Memory
parameter Isize = n + 12; // Isize - instruction width
logic [Isize-1:0] I; // I - instruction code

//------------------------------------------------
// module instantiations
pc #(.Psize(Psize)) progCounter (
        .clk(clk),
        .nreset(nreset),
        .PCincr(PCincr),
        .PCabsbranch(PCabsbranch),
        .PCrelbranch(PCrelbranch),
        .Branchaddr(I[Psize-1:0]), 
        .PCout(ProgAddress));  //[o]

prog #(.Psize(Psize), .Isize(Isize)) progMemory (
        .address(ProgAddress),
        .I(I));  //[o]

decoder dec (
        .opcode(I[Isize-1:Isize-6]),
        .flags(flags), // ALU flags N,Z,C,V
        .Bcond(I[n-1]), // Branch condition
        .Bstus(Bstus), // Branch status
        .PCincr(PCincr),  //[o]
        .PCabsbranch(PCabsbranch),  //[o]
        .PCrelbranch(PCrelbranch),  //[o]
        .ALUfunc(ALUfunc),  //[o]
        .imm(imm),  //[o]
        .fetch(fetch),  //[o]
        .show(show),  //[o]
        .w(w));  //[o]

regs #(.n(n)) gpr (
        .clk(clk),
        .w(w),
        .Wdata(Wdata),  // write Wdata to Rdata2
        .Raddr2(I[Isize-7:Isize-9]),  // reg %d number
        .Raddr1(I[Isize-10:Isize-12]), // reg %s number
        .Rdata1(Rdata1),  //[o]
        .Rdata2(Rdata2)); //[o]

alu #(.n(n)) iu (
        .a(Rdata1),
        .b(Alub),
        .func(ALUfunc),
        .flags(flags),  //[o], ALU flags N,Z,C,V
        .result(Wdata));  //[o], ALU result -> destination reg

// create MUX for immediate operand
assign Alub = (imm ? (fetch ? x[n-1:0] : I[n-1:0]) : Rdata2);
// connect ALU result to outport
//assign outport = (show ? Wdata : 8'd0);
always_ff @(posedge clk or negedge nreset)
begin
	if (!nreset) // sync reset
                outport <= 8'd0;
	else if(show)
                outport <= Wdata;
end

endmodule // end of module picoMIPS