interface apb4_if #(parameter int AW=24, DW=32)(input logic pclk, presetn);
  logic [AW-1:0] paddr; logic psel, penable, pwrite; logic [DW-1:0] pwdata;
  logic [DW/8-1:0] pstrb; logic [2:0] pprot; logic [DW-1:0] prdata;
  logic pready, pslverr;
  modport master(output paddr,psel,penable,pwrite,pwdata,pstrb,pprot,input prdata,pready,pslverr);
  modport slave(input paddr,psel,penable,pwrite,pwdata,pstrb,pprot,output prdata,pready,pslverr);
endinterface
