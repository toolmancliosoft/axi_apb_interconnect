module address_decode_tb; logic [39:0] addr;logic [2:0] target;logic hit;axi_address_decoder dut(.*);
 initial begin addr=40'h0040000010;#1;assert(hit&&target==1);addr=40'h0060000100;#1;assert(hit&&target==3);addr=40'h0070000000;#1;assert(!hit&&target==6);$finish;end
endmodule
