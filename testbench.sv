//testbench for pipelined divider
module top();
parameter DIVIDEND =4;
parameter DIVISOR =2;
parameter TRUE = 1'b1;
parameter FALSE  = 1'b0;
parameter CLOCK_CYCLE  = 20;
parameter CLOCK_WIDTH  = CLOCK_CYCLE/2;
 
logic clock;
bit [DIVIDEND-1:0] dividend;
bit [DIVISOR-1:0] divisor;
wire [DIVIDEND-1:0] quotient;
wire [DIVISOR-1:0] remainder;

  
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
      		{divisor,dividend}=i;
        	#20
		if(quotient[DIVIDEND-1:0]!==(dividend/divisor))
		begin
			if(divisor===0)
				$display("Divide by zero");
         		else
			begin
				$display("error");
         			$display("quotient %d, expected: %d", quotient[DIVIDEND-1:0],(dividend/divisor));
            			$display("remainder: %d, expected: %d", remainder, (dividend - ((dividend/divisor)*divisor)));
			end
		end
       		else if(remainder!==dividend - (quotient*divisor))
        	begin
          		$display("error remainder: %d, expected: %d", remainder, (dividend - ((dividend/divisor)*divisor)));
        	end

     	 	else

         		$display("dividend: %d divisor: %d quotient: %d remainder %d", dividend, divisor, quotient, remainder);

      	end        
end
  
initial
  begin
    #2000
    $stop;
  end
endmodule
