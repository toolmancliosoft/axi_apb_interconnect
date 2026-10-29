module apb_fabric(apb4_if.slave upstream, apb4_if.master downstream[8]);
  logic [7:0] sel; logic decode_error; integer i;
  apb_decoder u_decode(.paddr(upstream.paddr),.psel_decode(sel),.decode_error);
  always_comb begin
    upstream.prdata='0;upstream.pready=1'b0;upstream.pslverr=decode_error&&upstream.psel;
    for(i=0;i<8;i=i+1) begin
      downstream[i].paddr=upstream.paddr;downstream[i].penable=upstream.penable;downstream[i].pwrite=upstream.pwrite;
      downstream[i].pwdata=upstream.pwdata;downstream[i].pstrb=upstream.pstrb;downstream[i].pprot=upstream.pprot;
      downstream[i].psel=upstream.psel&&sel[i];
      if(sel[i]) begin upstream.prdata=downstream[i].prdata;upstream.pready=downstream[i].pready;upstream.pslverr=downstream[i].pslverr;end
    end
    if(upstream.psel&&decode_error) upstream.pready=1'b1;
  end
endmodule
