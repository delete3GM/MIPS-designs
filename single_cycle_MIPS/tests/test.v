`timescale 1ns/1ps
module test;
    reg clk=0,rst=0;
    integer i;

    mips my_mips(clk,rst);

    initial begin
        clk=0;
        rst=0;
        #5
         rst=1;
        #15
         rst=0;

        $readmemh("tests/p1-test.txt",my_mips.ifu1.im); // load into im
        $dumpfile("build/test.vcd");
        $dumpvars(0, test);

        #2000
         $display("Register values:");
        for(i=0;i<32;i=i+1) begin
            $display("t[%0d] = %h " , i, my_mips.gpr1.t[i]);
        end
        $finish;
    end
    always begin
        #10 clk=~clk;
    end
endmodule

