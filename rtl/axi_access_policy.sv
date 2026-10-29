module axi_access_policy(input logic [39:0] addr,input logic [2:0] prot,output logic allowed);
  import dx1_addr_map_pkg::*;
  logic nonsecure, secure_region;
  assign nonsecure=prot[1];
  always_comb begin
    secure_region=((addr>=40'h0063000000)&&(addr<40'h0065000000));
    allowed=!(nonsecure&&secure_region);
  end
endmodule
