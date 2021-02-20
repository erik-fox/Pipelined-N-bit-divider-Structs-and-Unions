task sendByte(bit [7:0] din[$]);
  foreach(din[i])
  $display("Byte: %h",din.pop_front);
endtask
