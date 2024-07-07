module im(addr, dout);
  	input [9:0]addr;
  	output [31:0]dout;
  	reg [7:0] im [1023:0];
	
	initial 
	begin
		$readmemh("tests/p2-test.txt",im);
	end
	
	assign dout = {im[addr], im[addr+1], im[addr+2], im[addr+3]};	
endmodule
