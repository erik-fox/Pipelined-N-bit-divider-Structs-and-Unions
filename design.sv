//Divider Stage Module and Pipelined Divider Module
module pipelinediv #(parameter DIVIDENDLEN =16, parameter DIVISORLEN=8)(clock,dividend,divisor,quotient,remainder);
localparam DATAPATHLEN = DIVIDENDLEN + DIVISORLEN -1;
input clock;
input [DIVIDENDLEN-1:0]dividend;
input [DIVISORLEN-1:0]divisor;
output [DIVIDENDLEN-1:0]quotient;
output [DIVISORLEN-1:0]remainder;

  wire[DIVIDENDLEN-1:0]w1[DIVIDENDLEN];  //qout
  wire[DATAPATHLEN-1:0]w2[DIVIDENDLEN];    //dout
  wire[DIVOSORLEN-1:0]w3[DIVIDENDLEN];     //divout
  
	bit [DIVISORLEN+DATAPATHLEN+DIVIDENDLEN-1:0]register[DIVIDENDLEN];//bits in divisor, datapath, quotient 

genvar i;

generate
  for (i=0;i<=(DIVIDENDLEN)-1;i++)
	begin:divider
        if(i==0)//first
	    	begin
          dividerslice #(((DIVIDENDLEN-1)-i),DIVIDENDLEN,DIVISORLEN) d((dividend,divisor,DIVIDENDLEN'b0,w1[i],w2[i],w3[i]);
		    end
        else
        begin
          dividerslice #(((DIVIDENDLEN-1)-i),DIVIDENDLEN,DIVISORLEN) d((w2[i-1],w3[i-1],w1[i-1],w1[i],w2[i],w3[i]);
		    end
	end
endgenerate

always_ff @(posedge clock)
begin
	for(int j=0;j<=(DIVIDENDLEN)-1;j++)
		register<={w1[i],w2[i],w3[i]};
end
                                                                       
  
endmodule

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

