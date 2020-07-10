module mux32(input logic  d[32], s[5], output logic y); 

	mux4 m1(d[0] , d[1] , d[2] , d[3] , s[0], s[1], y0);
	mux4 m2(d[4] , d[5] , d[6] , d[7] , s[0], s[1], y1);
	mux4 m3(d[8] , d[9] , d[10], d[11], s[0], s[1], y2);
	mux4 m4(d[12], d[13], d[14], d[15], s[0], s[1], y3);
	mux4 m5(d[16], d[17], d[18], d[19], s[0], s[1], y4);
	mux4 m6(d[20], d[21], d[22], d[23], s[0], s[1], y5);
	mux4 m7(d[24], d[25], d[26], d[27], s[0], s[1], y6);
	mux4 m8(d[28], d[29], d[30], d[31], s[0], s[1], y7);
	
	mux4 m9 (y0, y1, y2, y3, s[2], s[3], y8);
	mux4 m10(y4, y5, y6, y7, s[2], s[3], y9);
	
	mux2 m11(y8, y9, s[4], y);

endmodule
