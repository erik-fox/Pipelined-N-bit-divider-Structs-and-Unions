package tcp;
  typedef  struct packed {
    bit [15:0] sourceport;
    bit [15:0] destport;
    bit [31:0] seqport;
    bit [31:0] acknum;
    bit [3:0] offset;
    bit [2:0] reserved;
    bit ns, cwr,ece,urg,ack,psh,rst,syn,fin;
    bit [15:0] windowsize;
    bit [15:0] checksum;
    bit [15:0] urgptr;
    bit [319:0] option;
  }tcpheader;
  
endpackage
