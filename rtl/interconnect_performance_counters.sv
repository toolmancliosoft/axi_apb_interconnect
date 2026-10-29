module interconnect_performance_counters(input logic clk,rst_n,input logic aw_fire,ar_fire,w_stall,r_stall,decode_error,output logic [63:0] writes,reads,write_stalls,read_stalls,decode_errors);
  function automatic logic [63:0] sat_inc(input logic [63:0] v); return (&v)?v:v+1'b1; endfunction
  always_ff @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin writes<=0;reads<=0;write_stalls<=0;read_stalls<=0;decode_errors<=0;end
    else begin if(aw_fire)writes<=sat_inc(writes);if(ar_fire)reads<=sat_inc(reads);if(w_stall)write_stalls<=sat_inc(write_stalls);if(r_stall)read_stalls<=sat_inc(read_stalls);if(decode_error)decode_errors<=sat_inc(decode_errors);end
  end
endmodule
