//-------------------------------------------------------------------------------
//** Part       : ELEC6234_CourseWork01
//** File name  : prog_tb.sv
//** Description: testbench for picoMIPS program memory.
//** Author     : Haosen Yu
//** Email      : haosenyu@hotmail.com or hy3u21@soton.ac.uk
//** Revision   : Version 1.0
//** Date       : 17/04/2022 12:00:00
//-------------------------------------------------------------------------------
module prog_tb;

parameter Psize = 5;
parameter Isize = 20;

logic [Psize-1:0] address;
logic [Isize-1:0] I;

// create program memory object
prog #(.Psize(Psize), .Isize(Isize)) progMemory (.address(address), .I(I));
//------------------------------------------------
initial // for 320ns
      begin
                  address = 5'b00000;
            #10ns address = 5'b00001;
            #10ns address = 5'b00010;
            #10ns address = 5'b00011;
            #10ns address = 5'b00100;
            #10ns address = 5'b00101;
            #10ns address = 5'b00110;
            #10ns address = 5'b00111;
            #10ns address = 5'b01000;
            #10ns address = 5'b01001;
            #10ns address = 5'b01010;
            #10ns address = 5'b01011;
            #10ns address = 5'b01100;
            #10ns address = 5'b01101;
            #10ns address = 5'b01110;
            #10ns address = 5'b01111;
            #10ns address = 5'b10000;
            #10ns address = 5'b10001;
            #10ns address = 5'b10010;
            #10ns address = 5'b10011;
            #10ns address = 5'b10100;
            #10ns address = 5'b10101;
            #10ns address = 5'b10110;
            #10ns address = 5'b10111;
            #10ns address = 5'b11000;
            #10ns address = 5'b11001;
            #10ns address = 5'b11010;
            #10ns address = 5'b11011;
            #10ns address = 5'b11100;
            #10ns address = 5'b11101;
            #10ns address = 5'b11110;
            #10ns address = 5'b11111;
      end
endmodule // end of module prog_tb