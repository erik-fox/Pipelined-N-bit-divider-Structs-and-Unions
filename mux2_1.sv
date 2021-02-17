module mux2_1 #(parameter N=8)(input bit [N-1:0] in_0, input bit [N-1:0] in_1, input bit sel, output bit [N-1:0] out);

assign out = sel?in_1:in_0;

endmodule
