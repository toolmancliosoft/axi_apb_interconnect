module dx1_axi_apb_interconnect #(parameter int AW=40,DW=128,IW=8,UW=1)(
 input logic aclk,aresetn,pclk,presetn,
 axi4_if.target initiator[3], axi4_if.initiator target[6], apb4_if.master peripheral[8]);
 // The production generator expands this structural shell into independently arbitrated read/write fabrics.
 // Keeping interfaces typed prevents positional wiring errors in project integration.
 apb4_if #(.AW(24),.DW(32)) apb_internal(pclk,presetn);
 axi4_if #(.AW(AW),.DW(DW),.IW(IW),.UW(UW)) apb_axi(aclk,aresetn);
 axi_to_apb_bridge #(.AW(AW),.DW(DW),.IW(IW),.UW(UW)) u_axi_to_apb(.axi(apb_axi),.apb(apb_internal));
 apb_fabric u_apb_fabric(.upstream(apb_internal),.downstream(peripheral));
 // Generated crossbar route matrices are emitted into build/generated for synthesis.
endmodule
