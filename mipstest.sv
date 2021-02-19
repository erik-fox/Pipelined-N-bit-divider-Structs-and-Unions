module top();
  
import mips::*;
mipsinst iinstr=32'b00100010011010100000000000000100;
mipsinst jinstr=32'b00001000000000000000000100000001;
mipsinst rinstr=32'b00000010001100101000000000100000;
  
initial
begin
  $dumpfile("dump.vcd"); $dumpvars;
  #10
  $display("r  - opcode: %b rs: %b rt: %b rd: %b shift: %b func: %b",rinstr.r.opcode,rinstr.r.rs, rinstr.r.rt,rinstr.r.rd,rinstr.r.shift,rinstr.r.func);
  $display("expected - 000000 10001 10010 10000 00000 100000");
  $display("i - opcode: %b rs: %b rt: %b imm: %b",iinstr.i.opcode, iinstr.i.rs,iinstr.i.rt, iinstr.i.imm);
  $display("expected - 001000 10011 01010 0000000000000100");
  $display("j - opcode: %b address: %b", jinstr.j.opcode, jinstr.j.address);
  $display("expected - 000010 00000000000000000100000001");
end
  
  
  
endmodule
