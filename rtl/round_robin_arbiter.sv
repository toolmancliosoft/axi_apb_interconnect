module round_robin_arbiter #(parameter int N=3)(input logic clk,rst_n,input logic [N-1:0] request,input logic accept,output logic [N-1:0] grant,output logic grant_valid);
  localparam int PW=(N<=1)?1:$clog2(N); logic [PW-1:0] pointer_q; integer k,idx;
  always_comb begin
    grant='0;grant_valid=1'b0;
    for(k=0;k<N;k=k+1) begin idx=pointer_q+k; if(idx>=N) idx=idx-N; if(request[idx]&&!grant_valid) begin grant[idx]=1'b1;grant_valid=1'b1;end end
  end
  always_ff @(posedge clk or negedge rst_n) begin
    if(!rst_n) pointer_q<='0;
    else if(accept&&grant_valid) begin
      if(grant[N-1]) pointer_q<='0; else for(k=0;k<N-1;k=k+1) if(grant[k]) pointer_q<=k+1;
    end
  end
endmodule
