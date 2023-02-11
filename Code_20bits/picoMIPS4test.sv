//-------------------------------------------------------------------------------
//** Part       : ELEC6234_CourseWork01
//** File name  : picoMIPS4test.sv
//** Description: Versions of picoMIPS for testing.
//** Author     : Haosen Yu
//** Email      : haosenyu@hotmail.com or hy3u21@soton.ac.uk
//** Revision   : Version 1.0
//** Date       : 16/04/2022 12:00:00
//-------------------------------------------------------------------------------
// synthesise to run on Altera DE0 for testing and demo
module picoMIPS4test #(parameter n = 24) //clock divides by 2^n, adjust n if necessary.
(input logic fastclk,  // 50MHz Altera DE0 clock
 input logic nreset, // nreset
 input logic Bstus, // Connect to SW[8]
 input logic [7:0] SW, // Switches SW0..SW7
 output logic [7:0] LED // LEDs
);

logic clk; // slow clock, about 10Hz
counter #(.n(n)) count (.fastclk(fastclk),.clk(clk)); // slow clk from counter

// to obtain the cost figure, synthesise your design without the counter 
// and the picoMIPS4test module using Cyclone V E as target
// and make a note of the synthesis statistics
picoMIPS u_picoMIPS (.clk(clk), .nreset(nreset), .Bstus(Bstus), .x(SW[7:0]), .outport(LED));
  
endmodule // end of module picoMIPS4test