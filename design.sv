//Divider Stage Module and Pipelined Divider Module
module dividerslice #(parameter SHIFT=5 ,parameter DIVIDENDLEN=16, parameter DIVISORLEN = 8)(din,divisor,quotient,dout,divout);
localparam DATAPATHLEN = DIVIDENDLEN + DIVISORLEN -1;

input[DATAPATHLEN-1:0]din;
input[DIVISORLEN-1:0]divisor;
output [DATAPATHLEN-1:0] quotient;
output [DATAPATHLEN-1:0] dout;
output[DIVISORLEN-1:0] divout;
  
wire [DATAPATHLEN-1:0] w1;
wire [DATAPATHLEN-1:0] w2;
wire [DATAPATHLEN-1:0] w3;



  nbitshifter #(SHIFT ,DIVISORLEN,DATAPATHLEN) s0(divisor,w1);
  twoscomplement#(DATAPATHLEN) t0(w1,w2);
  nbitfulladder #(DATAPATHLEN) a0(in,w2,w3,quotient[SHIFT]);
  mux2_1 #(DATAPATHLEN) m0(dividend,w3,quotient[SHIFT],dout);
  assign divout = divisor;
  
endmodule

