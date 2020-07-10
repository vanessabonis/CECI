module mux2(input logic d0, d1, input logic s, output tri y);
 
 tristate t0(d0, ns, y);
 tristate t1(d1, s, y);
 inversor inv(s, ns);
 
endmodule

