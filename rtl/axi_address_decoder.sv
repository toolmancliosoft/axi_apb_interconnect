module axi_address_decoder(import axi_apb_interconnect_pkg::*;)(input logic [39:0] addr, output logic [2:0] target, output logic hit);
  import dx1_addr_map_pkg::*;
  always_comb begin
    target=TGT_ERROR[2:0]; hit=1'b1;
    if(address_match(addr,BOOT_SRAM_BASE,BOOT_SRAM_MASK)) target=TGT_BOOT_SRAM[2:0];
    else if(address_match(addr,ACCEL_BASE,ACCEL_MASK)) target=TGT_ACCEL[2:0];
    else if(address_match(addr,DMA_BASE,DMA_MASK)) target=TGT_DMA[2:0];
    else if(address_match(addr,GMAC_BASE,GMAC_MASK)) target=TGT_GMAC[2:0];
    else if(address_match(addr,APB_BASE,APB_MASK)) target=TGT_APB[2:0];
    else if(address_match(addr,DDR_BASE,DDR_MASK)) target=TGT_DDR[2:0];
    else begin target=TGT_ERROR[2:0]; hit=1'b0; end
  end
endmodule
