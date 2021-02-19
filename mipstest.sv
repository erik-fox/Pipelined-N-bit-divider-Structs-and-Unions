module top();
  
import mips::*;
mipsinst iinstr=32'b00100010011010100000000000000100;
mipsinst jinstr=32'b00001000000000000000000100000001;
mipsinst rinstr=32'b00000010001100101000000000100000;
  
initial
begin
  $dumpfile("dump.vcd"); $dumpvars;
  #10
  $display("r - opcode: %b rs: %b rt: %b rd: %b shift: %b func: %b",rinstr.r.opcode,rinstr.r.rs, rinstr.r.rt,rinstr.r.rd,rinstr.r.shift,rinstr.r.func);
  $display("i - opcode: %b rs: %b rt: %b imm: %b",iinstr.i.opcode, iinstr.i.rs,iinstr.i.rt, iinstr.i.imm);
  $display("j - opcode: %b address: %b", jinstr.j.opcode, jinstr.j.address);
  
end
  
  
  
endmodule
