module top();
  
import mips::*;
  mipsinst instr=32'h87654321;
  
initial
begin
  $dumpfile("dump.vcd"); $dumpvars;
  #10
  $display("r - opcode: %b rs: %b rt: %b rd: %b shift: %b func: %b",instr.r.opcode,instr.r.rs, instr.r.rt,instr.r.rd,instr.r.shift,instr.r.func);
  $display("i - opcode: %b rs: %b rt: %b imm: %b",instr.i.opcode, instr.i.rs,instr.i.rt, instr.i.imm);
  $display("j - opcode: %b address: %b", instr.j.opcode, instr.j.address);
  
end
  
  
  
endmodule
