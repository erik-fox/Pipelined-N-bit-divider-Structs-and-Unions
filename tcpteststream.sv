task sendSegmentHeader(tcpheader din);
  bit [7:0] stream [$];
  stream = {>>{din}};
  for(int i =0; i<= (din.offset * 4) - 1; i++)
      sendByte(stream.pop_front);

endtask
