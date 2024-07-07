`timescale 1ns/1ps
module test;
	reg clk,reset;
	integer i;

	mips mips1(clk,reset);
	
	initial begin
		clk = 0;
		reset = 0;
		#5 reset = 1;
		#15 reset = 0;

    	$dumpfile("build/test.vcd"); 
    	$dumpvars(0, test);	

		#6000
		$display("Register values:");
  		for(i = 0; i < 32; i = i + 1)
    		$display("reg[%0d] = %h", i, mips1.GPR1.Regs[i]); 	
			
		$finish;
	end

	always 
		#10 clk = ~clk;
endmodule
