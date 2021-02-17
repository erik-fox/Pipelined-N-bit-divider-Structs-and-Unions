module nbitshifter #(parameter BITSHIFT = 15, parameter BITIN =8 , parameter BITOUT=23) (input bit [BITIN-1:0]in, output bit [BITOUT-1:0]out);

assign out = in<<BITSHIFT;

endmodule
