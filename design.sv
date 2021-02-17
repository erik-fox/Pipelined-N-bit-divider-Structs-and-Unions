//Divider Stage Module and Pipelined Divider Module
module dividerslice #(parameter SHIFT=5 ,parameter DIVIDENDLEN=16, parameter DIVISORLEN = 8)(din,divin,qin,qout,dout,divout);
localparam DATAPATHLEN = DIVIDENDLEN + DIVISORLEN -1;

input[DATAPATHLEN-1:0]din;
input[DIVISORLEN-1:0]divin;
input[DIVIDENDLEN-1:0]qin;
output bit [DIVIDENDLEN-1:0] qout;
output [DATAPATHLEN-1:0] dout;
output[DIVISORLEN-1:0] divout;
  
wire [DATAPATHLEN-1:0] w1;
wire [DATAPATHLEN-1:0] w2;
wire [DATAPATHLEN-1:0] w3;



  nbitshifter #(SHIFT ,DIVISORLEN,DATAPATHLEN) s0(divin,w1);
  twoscomplement#(DATAPATHLEN) t0(w1,w2);
  nbitfulladder #(DATAPATHLEN) a0(din,w2,w3,qout[SHIFT]);
  mux2_1 #(DATAPATHLEN) m0(din,w3,qout[SHIFT],dout);
  
  always_comb
    begin
      if(SHIFT!=DIVIDENDLEN-1)
          qout[DIVIDENDLEN-1:SHIFT+1]= qin[DIVIDENDLEN-1:SHIFT+1];
    end
  
  assign divout = divin;
  
endmodule

