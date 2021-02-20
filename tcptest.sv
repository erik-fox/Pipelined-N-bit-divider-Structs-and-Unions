import tcp::*;
module top();
  
  initial
    begin
      
    end
endmodule
               
task sendByte(bit [7:0] din);
  $display("Byte: %b",din);
endtask

task sendSegmentHeader(tcpheader din);
  for(int i =0; i<= din.offset*4;i++)
    sendByte(din[480-1-(i*8)-:8];
endtask

             
            
