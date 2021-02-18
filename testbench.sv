//testbench for pipelined divider
module top();
parameter DIVIDEND =16;
parameter DIVISOR =8;
parameter TRUE = 1'b1;
parameter FALSE  = 1'b0;
parameter CLOCK_CYCLE  = 20;
parameter CLOCK_WIDTH  = CLOCK_CYCLE/2;
 
logic clock;
bit [DIVIDEND-1:0] dividend;
bit [DIVISOR-1:0] divisor;
wire [DIVIDEND-1:0] quotient;
wire [DIVISOR-1:0] remainder;

bit [DIVIDEND+DIVISOR-1:0] queue [$];
  bit [DIVIDEND+DIVISOR-1:0] tbcheck;
  
pipelinediv  #(DIVIDEND,DIVISOR)d0(clock, dividend,divisor,quotient, remainder);

initial
begin
	clock = FALSE;
	forever #CLOCK_WIDTH clock = ~clock;
end
  
initial
begin
	$dumpfile("dump.vcd"); $dumpvars;
	for(int i=0; i<=(1<<(DIVISOR+DIVIDEND)); i++)
   	begin
      		#20 
      		{divisor,dividend}=i;
    	end
	$stop;
end

always @(posedge clock)
begin
  #1
      queue.push_front({divisor,dividend});
  		if(queue.size()===(DIVIDEND))
      begin
      		tbcheck = queue.pop_back();
      		if(tbcheck[DIVIDEND-1:0]/tbcheck[DIVIDEND+DIVISOR-1:DIVIDEND]!==quotient)
      		begin
              		if(tbcheck[DIVIDEND+DIVISOR-1:DIVIDEND]===0)
				$display("Divide by zero");
         		else
			begin
				$display("error");
         			$display("quotient %d, expected: %d", quotient[DIVIDEND-1:0],(tbcheck[DIVIDEND-1:0]/tbcheck[DIVIDEND+DIVISOR-1:DIVIDEND]));
            			$display("remainder: %d, expected: %d", remainder, (tbcheck[DIVIDEND-1:0] - ((tbcheck[DIVIDEND-1:0]/tbcheck[DIVIDEND+DIVISOR-1:DIVIDEND])*tbcheck[DIVIDEND+DIVISOR-1:DIVIDEND])));
			end
                end
       		else if(remainder!==tbcheck[DIVIDEND-1:0] - (quotient*tbcheck[DIVIDEND+DIVISOR-1:DIVIDEND]))
          		$display("error remainder: %d, expected: %d", remainder, (tbcheck[DIVIDEND-1:0] - ((tbcheck[DIVIDEND-1:0]/tbcheck[DIVIDEND+DIVISOR-1:DIVIDEND])*tbcheck[DIVIDEND+DIVISOR-1:DIVIDEND])));
`ifdef DEBUG     
	 	else
         		$display("dividend: %d divisor: %d quotient: %d remainder %d", tbcheck[DIVIDEND-1:0], tbcheck[DIVIDEND+DIVISOR-1:DIVIDEND], quotient,remainder);
`endif
	end
end
endmodule
