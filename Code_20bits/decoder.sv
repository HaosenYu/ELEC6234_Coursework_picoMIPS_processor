//-------------------------------------------------------------------------------
//** Part       : ELEC6234_CourseWork01
//** File name  : decoder.sv
//** Description: picoMIPS instruction decoder.
//** Author     : Haosen Yu
//** Email      : haosenyu@hotmail.com or hy3u21@soton.ac.uk
//** Revision   : Version 1.0
//**            : Version 1.0 is based on tjk's work: 26/10/2012
//**            : Version 1.0 includes the decoding of NOP, ADD, ADDI, and branches.
//** Date       : 16/04/2022 12:00:00
//-------------------------------------------------------------------------------
`include "alucodes.sv"
`include "opcodes.sv"
//------------------------------------------------
module decoder
(input logic [5:0] opcode, // top 6 bits of instruction
 input logic [3:0] flags, // ALU flags N,Z,C,V
 input logic Bcond, // Branch condition
 input logic Bstus, // Branch status, connected to specified switch
 //output signals
 // PC control
 output logic PCincr, PCabsbranch, PCrelbranch,
 // ALU control
 output logic [2:0] ALUfunc, 
 // imm mux control
 output logic imm,
 // fetch mux control
 output logic fetch,
  // output display control
 output logic show,
 // register file control
 output logic w
);
//------------------------------------------------
// instruction decoder
logic takeBranch; // temp variable to control conditional branching
always_comb
begin
   // set default output signal values for NOP instruction
   PCincr = 1'b1; // PC increments by default
	PCabsbranch = 1'b0;
   PCrelbranch = 1'b0;
   ALUfunc = `RNOP; // opcode[2:0]; 
   imm = 1'b0;
   fetch = 1'b0;
   show = 1'b0;
   w = 1'b0; 
   takeBranch =  1'b0; 
   case(opcode)
      `NOP : ; // No operation, ADDI %d, %0, 0 => clear %d.
      `ADD :begin // register-register
               w = 1'b1; // write result to dest register
               ALUfunc = `RADD;
            end
      `ADDI:begin // register-immediate
               w = 1'b1; // write result to dest register
               imm = 1'b1; // set ctrl signal for imm operand MUX
               ALUfunc = `RADD;
            end
      `ADDF:begin // register-immediate
               w = 1'b1; // write result to dest register
               imm = 1'b1; // set ctrl signal for imm operand MUX
               fetch = 1'b1; // set ctrl signal for fetch inport data operand MUX
               ALUfunc = `RADD;
            end
      `SUB :begin // register-register
               w = 1'b1; // write result to dest register
               ALUfunc = `RSUB;
            end
      `SUBI:begin // register-immediate
               w = 1'b1; // write result to dest register
               imm = 1'b1; // set ctrl signal for imm operand MUX
               ALUfunc = `RSUB;
            end
      `MUL :begin // register-register
					w = 1'b1; // write result to dest register
					ALUfunc = `RMUL;
				end
      `MULI:begin // register-immediate
					w = 1'b1; // write result to dest register
					imm = 1'b1; 
					ALUfunc = `RMUL;
				end
      `SHOW: begin
               show = 1'b1;
               ALUfunc = `RADD;
            end
      // branches
      `BAT :begin
               if(Bstus == Bcond)
                  takeBranch =  1'b1; // branch at specified conditions
            end
      //`BEQ :takeBranch =  flags[2]; // branch if Z==1
      //`BNE :takeBranch = ~flags[2]; // branch if Z==0
      //`BGE :takeBranch = ~flags[3]; // branch if N==0
      //`BLT :takeBranch =  flags[1]; // branch if C==1
      default: $error("unimplemented opcode: %h",opcode);
   endcase
  
   if(takeBranch) // branch condition is true
   begin
      PCincr = 1'b0;
	   PCrelbranch = 1'b1; 
   end
end

endmodule // end of module decoder