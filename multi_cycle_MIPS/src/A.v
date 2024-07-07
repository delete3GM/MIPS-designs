module A(clk, busA_in, busA);
    input clk;
    input [31:0] busA_in;
    output reg [31:0]busA;
  
    always @(posedge clk) 
    	busA = busA_in;
		 
endmodule