module fulladder (a,b, cin, s, cout);
input bit a, b, cin;
output bit s, cout;

always_comb
begin
	s=a^b^cin;
	cout=(a&b)|((a^b)&cin);
end

endmodule


