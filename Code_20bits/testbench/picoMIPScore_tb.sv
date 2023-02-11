//-------------------------------------------------------------------------------
//** Part       : ELEC6234_CourseWork01
//** File name  : picoMIPScore_tb.sv
//** Description: testbench for picoMIPS core without counter.
//** Author     : Haosen Yu
//** Email      : haosenyu@hotmail.com or hy3u21@soton.ac.uk
//** Revision   : Version 1.0
//** Date       : 17/04/2022 12:00:00
//-------------------------------------------------------------------------------
`include "alucodes.sv"
//------------------------------------------------
module picoMIPScore_tb;

logic clk, nreset, Bstus;  // clock signal
logic [7:0] SW; // Switches SW0..SW9
logic [7:0] LED; // LEDs

// create object
picoMIPS p0(.clk(clk), .nreset(nreset), .Bstus(Bstus), .x(SW[7:0]), .outport(LED));
//------------------------------------------------
initial 
begin 
	clk = 1'b0;
	forever #10ns clk = ~clk;
end

initial    
begin // for 500ns
	Bstus = 1'b0;
	nreset = 1'b0;
	@(posedge clk); nreset = 1'b1;

	//clear
	@(posedge clk);

	// wait 0
	@(posedge clk);
	Bstus = 1'b0;
	// wait 1
	@(posedge clk);
	Bstus = 1'b1;
	// input x1 twice
	@(posedge clk);
	SW[7:0] = 8'b00000001;
	@(posedge clk);

	// wait 0
	@(posedge clk);
	Bstus = 1'b0;
	// wait 1
	@(posedge clk);
	Bstus = 1'b1;
	// input y1 twice
	@(posedge clk);
	SW[7:0] = 8'b00000010;
	@(posedge clk);

	// wait 0
	@(posedge clk);
	Bstus = 1'b0;
	// calculate
	@(posedge clk); // MULT-1
	@(posedge clk); // MULT-2
	@(posedge clk); // MULT-3
	@(posedge clk); // MULT-4
	@(posedge clk); // ADD-1
	@(posedge clk); // ADD-2

	// display x2
	@(posedge clk);
	// wait 1
	@(posedge clk);
	Bstus = 1'b1;
	// display y2
	@(posedge clk);

	// wait 0
	@(posedge clk);
	Bstus = 1'b0;
	// repeat
	@(posedge clk);

end
endmodule // end of module picoMIPScore_tb