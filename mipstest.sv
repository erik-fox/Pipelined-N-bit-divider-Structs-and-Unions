module top();
  
import mips::*;
mipsinst iinstr=32'b00100010011010100000000000000100;
mipsinst jinstr=32'b00001000000000000000000100000001;
mipsinst rinstr=32'b00000010001100101000000000100000;
  
initial
begin
  $dumpfile("dump.vcd"); $dumpvars;
  #10
  $display("r - opcode: %b rs: %b rt: %b rd: %b shift: %b func: %b",instr.r.opcode,instr.r.rs, instr.r.rt,instr.r.rd,instr.r.shift,instr.r.func);
  $display("i - opcode: %b rs: %b rt: %b imm: %b",instr.i.opcode, instr.i.rs,instr.i.rt, instr.i.imm);
  $display("j - opcode: %b address: %b", instr.j.opcode, instr.j.address);
  
end
  
  
  
endmodule
