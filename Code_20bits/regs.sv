//-------------------------------------------------------------------------------
//** Part       : ELEC6234_CourseWork01
//** File name  : regs.sv
//** Description: picoMIPS 8 x n registers, %0 == 0.
//** Author     : Haosen Yu
//** Email      : haosenyu@hotmail.com or hy3u21@soton.ac.uk
//** Revision   : Version 1.0
//**            : Version 1.0 is based on tjk's work: 27/10/2012
//** Date       : 16/04/2022 12:00:00
//-------------------------------------------------------------------------------
module regs #(parameter n = 8) // n - data bus width
(input logic clk, w, // clk and write control
 input logic [n-1:0] Wdata,
 input logic [2:0] Raddr1, Raddr2,
 output logic [n-1:0] Rdata1, Rdata2
);
//------------------------------------------------
// Declare 2^3=8 n-bit registers, 3 is address width
logic [n-1:0] gpr [(1<<3)-1:0];

// write process, dest reg is Raddr2
always_ff @ (posedge clk)
begin
	if (w)
		gpr[Raddr2] <= Wdata;
end

// read process, output 0 if %0 is selected
always_comb
begin
	if (Raddr1==3'd0)
		Rdata1 =  {n{1'b0}};
	else
		Rdata1 = gpr[Raddr1];
	
	if (Raddr2==3'd0)
		Rdata2 =  {n{1'b0}};
	else
		Rdata2 = gpr[Raddr2];
end	
	
endmodule // end of module regs