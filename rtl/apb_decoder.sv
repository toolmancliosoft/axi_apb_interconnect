module apb_decoder(input logic [23:0] paddr,output logic [7:0] psel_decode,output logic decode_error);
  always_comb begin
    psel_decode='0;
    unique case(paddr[23:16])
      8'h00: psel_decode[0]=1'b1; 8'h01: psel_decode[1]=1'b1;
      8'h02: psel_decode[2]=1'b1; 8'h03: psel_decode[3]=1'b1;
      8'h04: psel_decode[4]=1'b1; 8'h05: psel_decode[5]=1'b1;
      8'h10: psel_decode[6]=1'b1; 8'h20: psel_decode[7]=1'b1;
      default: psel_decode='0;
    endcase
    decode_error=(psel_decode=='0);
  end
endmodule
