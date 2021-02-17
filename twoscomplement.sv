module twoscomplement #(parameter N =8)(input bit [N-1:0]in,output bit [N-1:0]out);

assign out = (~(in))+1;

endmodule
