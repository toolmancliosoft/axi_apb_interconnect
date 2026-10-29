interface axi4_if #(parameter int AW=40, DW=128, IW=8, UW=1)(input logic aclk, aresetn);
  localparam int SW=DW/8;
  logic [IW-1:0] awid; logic [AW-1:0] awaddr; logic [7:0] awlen; logic [2:0] awsize;
  logic [1:0] awburst; logic awlock; logic [3:0] awcache; logic [2:0] awprot;
  logic [3:0] awqos; logic [UW-1:0] awuser; logic awvalid, awready;
  logic [DW-1:0] wdata; logic [SW-1:0] wstrb; logic wlast; logic [UW-1:0] wuser; logic wvalid,wready;
  logic [IW-1:0] bid; logic [1:0] bresp; logic [UW-1:0] buser; logic bvalid,bready;
  logic [IW-1:0] arid; logic [AW-1:0] araddr; logic [7:0] arlen; logic [2:0] arsize;
  logic [1:0] arburst; logic arlock; logic [3:0] arcache; logic [2:0] arprot;
  logic [3:0] arqos; logic [UW-1:0] aruser; logic arvalid,arready;
  logic [IW-1:0] rid; logic [DW-1:0] rdata; logic [1:0] rresp; logic rlast;
  logic [UW-1:0] ruser; logic rvalid,rready;
  modport initiator(output awid,awaddr,awlen,awsize,awburst,awlock,awcache,awprot,awqos,awuser,awvalid,
    wdata,wstrb,wlast,wuser,wvalid,bready,arid,araddr,arlen,arsize,arburst,arlock,arcache,arprot,arqos,aruser,arvalid,rready,
    input awready,wready,bid,bresp,buser,bvalid,arready,rid,rdata,rresp,rlast,ruser,rvalid);
  modport target(input awid,awaddr,awlen,awsize,awburst,awlock,awcache,awprot,awqos,awuser,awvalid,
    wdata,wstrb,wlast,wuser,wvalid,bready,arid,araddr,arlen,arsize,arburst,arlock,arcache,arprot,arqos,aruser,arvalid,rready,
    output awready,wready,bid,bresp,buser,bvalid,arready,rid,rdata,rresp,rlast,ruser,rvalid);
endinterface
