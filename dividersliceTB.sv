module top();
parameter DIVIDENDLEN=3;
parameter DIVISORLEN = 2;
parameter SHIFT= 2;
localparam DATAPATHLEN = DIVIDENDLEN +DIVISORLEN -1;
bit [DATAPATHLEN-1:0]din;
bit [DIVISORLEN-1:0]divisor;
wire [DATAPATHLEN-1:0] quotient;
wire [DATAPATHLEN-1:0] dout;
wire [DIVISORLEN-1:0] divout;

dividerslice #(SHIFT,DIVIDENDLEN,DIVISORLEN) d0 (din,divisor,quotient,dout,divout);

initial
  begin
 	$dumpfile("dump.vcd"); $dumpvars;

    for(int i=0; i<= (1<<(DATAPATHLEN + DIVISORLEN)); i=i+1)
      begin
        #1
        {divisor,din}=i;
      end
  end


endmodule
