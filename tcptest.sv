module top();
import tcp::*;
task sendByte(bit [7:0] din);
  $display("Byte: %h",din);
endtask

task sendSegmentHeader(tcpheader din);
  for(int i =0; i<= (din.offset * 4) - 1; i++)
    sendByte(din[480-1-(i*8)-:8]);
endtask

tcpheader data;
  initial
    begin
       	$dumpfile("dump.vcd"); $dumpvars;
        data.sourceport=16'hAAAA;
        data.destport=16'hBBBB;
        data.seqport=32'hCCCCDDDD;
        data.acknum=32'hEEEEFFFF;
        data.offset=4'h6;
        data.reserved=3'b111;
        data.ns=1'b1;//5F
        {data.cwr,data.ece,data.urg,data.ack,data.psh,data.rst,data.syn,data.fin}=8'hAB;
        data.windowsize=16'hCDEF;
        data.checksum=16'hABCD;
        data.urgptr=16'hEFAB;
        sendSegmentHeader(data);
        
    end
endmodule
               

             
            
