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
wire[DIVISORLEN-1:0]w3[DIVIDENDLEN];     //divout
  
 bit [DIVISORLEN+DATAPATHLEN+DIVIDENDLEN-1:0]register[DIVIDENDLEN+1];//bits in divisor, datapath, quotient 
 bit [DIVIDENDLEN-1:0]q='0;
genvar i;

generate
	for (i=0;i<=(DIVIDENDLEN)-1;i++)
	begin:divider
             		dividerslice #(((DIVIDENDLEN-1)-i),DIVIDENDLEN,DIVISORLEN) d(register[i-1][DATAPATHLEN+DIVISORLEN-1:DIVISORLEN],register[i-1][DIVISORLEN-1:0],register[i-1][DIVISORLEN+DATAPATHLEN+DIVIDENDLEN-1:DATAPATHLEN+DIVISORLEN],w1[i],w2[i],w3[i]);
	end
endgenerate

always_ff @(posedge clock)
begin
	for(int j=0;j<=(DIVIDENDLEN);j++)
	begin
		if(j==0)
			register[j]<={q,dividend,divisor};		
		else
			register[j]<={w1[j],w2[j],w3[j]};
	end
end
assign quotient=register [DIVIDENDLEN-1] [DIVIDENDLEN+DIVISORLEN+DATAPATHLEN-1 : DIVISORLEN+DATAPATHLEN];
assign remainder= register[DIVIDENDLEN-1][DIVISORLEN+DATAPATHLEN-1:DIVISORLEN];								       
								      
								    
  
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
          		begin
			qout[DIVIDENDLEN-1:SHIFT+1]= qin[DIVIDENDLEN-1:SHIFT+1];
			end
    	end
  
assign divout = divin;
  
endmodule

