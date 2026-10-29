package axi_apb_interconnect_pkg;
  typedef enum logic [1:0] {AXI_OKAY=2'b00, AXI_EXOKAY=2'b01, AXI_SLVERR=2'b10, AXI_DECERR=2'b11} axi_resp_e;
  typedef struct packed {logic [39:0] base; logic [39:0] mask; logic secure_only;} region_t;
  localparam int NUM_AXI_INITIATORS=3;
  localparam int NUM_AXI_TARGETS=7;
  localparam int NUM_APB_TARGETS=8;
  localparam int TGT_BOOT_SRAM=0, TGT_ACCEL=1, TGT_DMA=2, TGT_GMAC=3, TGT_APB=4, TGT_DDR=5, TGT_ERROR=6;
  function automatic logic address_match(input logic [39:0] addr, input logic [39:0] base, input logic [39:0] mask);
    return (addr & mask)==(base & mask);
  endfunction
endpackage
