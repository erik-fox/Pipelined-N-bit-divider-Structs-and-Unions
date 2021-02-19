package mips;
  
  typedef union packed{
    struct packed {
      bit [31:26]opcode;//6bits
      bit [25:21]rs;//5bits
      bit [20:16]rt;//5bits
      bit [15:11]rd;//5bits
      bit [10:6]shift;//5bits
      bit [5:0]func;//6bits
    }r;
    struct packed {
      bit[31:26]opcode;//6bits
      bit [25:21]rs;//5bits
      bit [20:16]rt;//5bits
      bit [15:0]imm;//16bits
    }i;
    struct packed {
      bit [31:26]opcode;
      bit [25:0]address;
    }j;
  }mipsinst;
  
  
  
endpackage
