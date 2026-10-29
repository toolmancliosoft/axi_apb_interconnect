module axi_to_apb_bridge #(parameter int AW=40,DW=128,IW=8,UW=1)(axi4_if.target axi, apb4_if.master apb);
  typedef enum logic [2:0] {IDLE,W_DATA,W_SETUP,W_ACCESS,W_RESP,R_SETUP,R_ACCESS,R_RESP} state_e;
  state_e state_q; logic [AW-1:0] addr_q; logic [IW-1:0] id_q; logic [31:0] wdata_q; logic [3:0] wstrb_q;
  always_ff @(posedge axi.aclk or negedge axi.aresetn) begin
    if(!axi.aresetn) state_q<=IDLE;
    else case(state_q)
      IDLE: if(axi.awvalid&&axi.awready) state_q<=W_DATA; else if(axi.arvalid&&axi.arready) state_q<=R_SETUP;
      W_DATA: if(axi.wvalid&&axi.wready) state_q<=W_SETUP;
      W_SETUP: state_q<=W_ACCESS; W_ACCESS: if(apb.pready) state_q<=W_RESP;
      W_RESP: if(axi.bready) state_q<=IDLE;
      R_SETUP: state_q<=R_ACCESS; R_ACCESS: if(apb.pready) state_q<=R_RESP;
      R_RESP: if(axi.rready) state_q<=IDLE; default: state_q<=IDLE;
    endcase
  end
  always_ff @(posedge axi.aclk) begin
    if(state_q==IDLE&&axi.awvalid&&axi.awready) begin addr_q<=axi.awaddr;id_q<=axi.awid;end
    if(state_q==W_DATA&&axi.wvalid&&axi.wready) begin wdata_q<=axi.wdata[31:0];wstrb_q<=axi.wstrb[3:0];end
    if(state_q==IDLE&&axi.arvalid&&axi.arready) begin addr_q<=axi.araddr;id_q<=axi.arid;end
  end
  assign axi.awready=(state_q==IDLE); assign axi.wready=(state_q==W_DATA);
  assign axi.bvalid=(state_q==W_RESP); assign axi.bid=id_q; assign axi.bresp=apb.pslverr?2'b10:2'b00; assign axi.buser='0;
  assign axi.arready=(state_q==IDLE)&&!axi.awvalid; assign axi.rvalid=(state_q==R_RESP); assign axi.rid=id_q;
  assign axi.rdata={{(DW-32){1'b0}},apb.prdata}; assign axi.rresp=apb.pslverr?2'b10:2'b00; assign axi.rlast=1'b1; assign axi.ruser='0;
  assign apb.paddr=addr_q[23:0]; assign apb.psel=(state_q==W_SETUP)||(state_q==W_ACCESS)||(state_q==R_SETUP)||(state_q==R_ACCESS);
  assign apb.penable=(state_q==W_ACCESS)||(state_q==R_ACCESS); assign apb.pwrite=(state_q==W_SETUP)||(state_q==W_ACCESS);
  assign apb.pwdata=wdata_q; assign apb.pstrb=wstrb_q; assign apb.pprot=3'b000;
endmodule
