module axi_protocol_assertions #(parameter int AW=40,DW=128,IW=8)(axi4_if axi);
 property aw_stable; @(posedge axi.aclk) disable iff(!axi.aresetn) axi.awvalid&&!axi.awready |=> $stable({axi.awid,axi.awaddr,axi.awlen,axi.awsize,axi.awburst,axi.awprot}); endproperty
 property w_stable; @(posedge axi.aclk) disable iff(!axi.aresetn) axi.wvalid&&!axi.wready |=> $stable({axi.wdata,axi.wstrb,axi.wlast}); endproperty
 property ar_stable; @(posedge axi.aclk) disable iff(!axi.aresetn) axi.arvalid&&!axi.arready |=> $stable({axi.arid,axi.araddr,axi.arlen,axi.arsize,axi.arburst,axi.arprot}); endproperty
 assert property(aw_stable);assert property(w_stable);assert property(ar_stable);
endmodule
