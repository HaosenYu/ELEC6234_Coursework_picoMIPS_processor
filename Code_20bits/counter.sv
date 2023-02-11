//-------------------------------------------------------------------------------
//** Part       : ELEC6234_CourseWork01
//** File name  : counter.sv
//** Description: counter for slow clock.
//** Author     : Haosen Yu
//** Email      : haosenyu@hotmail.com or hy3u21@soton.ac.uk
//** Revision   : Version 1.0
//** Date       : 16/04/2022 12:00:00
//-------------------------------------------------------------------------------
module counter #(parameter n = 24) //clock divides by 2^n, adjust n if necessary.
(input logic fastclk,
 output logic clk // slow clock
);
//------------------------------------------------
logic [n-1:0] count = 'd0;

always_ff @(posedge fastclk)
  count <= count + 'd1;

assign clk = count[n-1]; // slow clock

endmodule