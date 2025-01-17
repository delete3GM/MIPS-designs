module im_1k(addr, dout) ;
    input   [9:0]  addr ;  // address bus
    output  [31:0]  dout ;  // 32-bit memory output
    reg     [7:0]  im[1023:0] ;
    assign dout={im[addr[9:0]],im[addr[9:0]+1],im[addr[9:0]+2],im[addr[9:0]+3]};
endmodule