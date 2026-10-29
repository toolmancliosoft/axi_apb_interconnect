module axi_default_error_target #(parameter int AW=40,DW=128,IW=8,UW=1)(axi4_if.target axi);
  logic write_active; logic [IW-1:0] write_id;
  always_ff @(posedge axi.aclk or negedge axi.aresetn) begin
    if(!axi.aresetn) begin write_active<=0;write_id<='0;axi.bvalid<=0;axi.rvalid<=0; end
    else begin
      if(axi.awvalid&&axi.awready) begin write_active<=1;write_id<=axi.awid;end
      if(write_active&&axi.wvalid&&axi.wready&&axi.wlast) begin axi.bvalid<=1;write_active<=0;end
      if(axi.bvalid&&axi.bready) axi.bvalid<=0;
      if(axi.arvalid&&axi.arready) axi.rvalid<=1;
      if(axi.rvalid&&axi.rready) axi.rvalid<=0;
    end
  end
  assign axi.awready=!write_active&&!axi.bvalid; assign axi.wready=write_active&&!axi.bvalid;
  assign axi.bid=write_id; assign axi.bresp=2'b11; assign axi.buser='0;
  assign axi.arready=!axi.rvalid; assign axi.rid=axi.arid; assign axi.rdata='0; assign axi.rresp=2'b11; assign axi.rlast=1'b1; assign axi.ruser='0;
endmodule
