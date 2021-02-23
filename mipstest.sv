module top();
  
import mips::*;
mipsinst iinstr=32'b00100010011010100000000000000100;
mipsinst jinstr=32'b00001000000000000000000100000001;
mipsinst rinstr=32'b00000010001100101000000000100000;
mipsinst instr[3]={iinstr,jinstr,rstr};
  
initial
begin
  $dumpfile("dump.vcd"); $dumpvars;
  #10
  for(int i=0;i<=3; i++}
      case(instr[i].r.opcode)
        6'b000000: $display("r  - opcode: %b rs: %b rt: %b rd: %b shift: %b func: %b",instr[i].r.opcode,instr[i].r.rs, instr[i].r.rt,instr[i].r.rd,instr[i].r.shift,instr[i].r.func);
        6'b000010,6'b000011 :  $display("j - opcode: %b address: %b", instr[i].j.opcode, instr[i].j.address);
        default: $display("i - opcode: %b rs: %b rt: %b imm: %b",instr[i].i.opcode, instr[i].i.rs,instr[i].i.rt, instr[i].i.imm);
      endcase
  

  



end
  
  
  
endmodule
