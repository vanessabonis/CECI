module decoder(sel, output_selector);

input logic [4:0] sel;
output logic [31:0] output_selector;

logic sel0_inv, sel1_inv, sel2_inv, sel3_inv, sel4_inv;

not inv0(sel0_inv, sel[0]);
not inv1(sel1_inv, sel[1]);
not inv2(sel2_inv, sel[2]);
not inv3(sel3_inv, sel[3]);
not inv4(sel4_inv, sel[4]);

and and00(output_selector[0], sel0_inv, sel1_inv, sel2_inv, sel3_inv, sel4_inv);
and and01(output_selector[1], sel[0], sel1_inv, sel2_inv, sel3_inv, sel4_inv);
and and02(output_selector[2], sel0_inv, sel[1], sel2_inv, sel3_inv, sel4_inv);
and and03(output_selector[3], sel[0], sel[1], sel2_inv, sel3_inv, sel4_inv);
and and04(output_selector[4], sel0_inv, sel1_inv, sel[2], sel3_inv, sel4_inv);
and and05(output_selector[5], sel[0], sel1_inv, sel[2], sel3_inv, sel4_inv);
and and06(output_selector[6], sel0_inv, sel[1], sel[2], sel3_inv, sel4_inv);
and and07(output_selector[7], sel[0], sel[1], sel[2], sel3_inv, sel4_inv);
and and08(output_selector[8], sel0_inv, sel1_inv, sel2_inv, sel[3], sel4_inv);
and and09(output_selector[9], sel[0], sel1_inv, sel2_inv, sel[3], sel4_inv);
and and10(output_selector[10], sel0_inv, sel[1], sel2_inv, sel[3], sel4_inv);
and and11(output_selector[11], sel[0], sel[1], sel2_inv, sel[3], sel4_inv);
and and12(output_selector[12], sel0_inv, sel1_inv, sel[2], sel[3], sel4_inv);
and and13(output_selector[13], sel[0], sel1_inv, sel[2], sel[3], sel4_inv);
and and14(output_selector[14], sel0_inv, sel[1], sel[2], sel[3], sel4_inv);
and and15(output_selector[15], sel[0], sel[1], sel[2], sel[3], sel4_inv);
and and16(output_selector[16], sel0_inv, sel1_inv, sel2_inv, sel3_inv, sel[4]);
and and17(output_selector[17], sel[0], sel1_inv, sel2_inv, sel3_inv, sel[4]);
and and18(output_selector[18], sel0_inv, sel[1], sel2_inv, sel3_inv, sel[4]);
and and19(output_selector[19], sel[0], sel[1], sel2_inv, sel3_inv, sel[4]);
and and20(output_selector[20], sel0_inv, sel1_inv, sel[2], sel3_inv, sel[4]);
and and21(output_selector[21], sel[0], sel1_inv, sel[2], sel3_inv, sel[4]);
and and22(output_selector[22], sel0_inv, sel[1], sel[2], sel3_inv, sel[4]);
and and23(output_selector[23], sel[0], sel[1], sel[2], sel3_inv, sel[4]);
and and24(output_selector[24], sel0_inv, sel1_inv, sel2_inv, sel[3], sel[4]);
and and25(output_selector[25], sel[0], sel1_inv, sel2_inv, sel[3], sel[4]);
and and26(output_selector[26], sel0_inv, sel[1], sel2_inv, sel[3], sel[4]);
and and27(output_selector[27], sel[0], sel[1], sel2_inv, sel[3], sel[4]);
and and28(output_selector[28], sel0_inv, sel1_inv, sel[2], sel[3], sel[4]);
and and29(output_selector[29], sel[0], sel1_inv, sel[2], sel[3], sel[4]);
and and30(output_selector[30], sel0_inv, sel[1], sel[2], sel[3], sel[4]);
and and31(output_selector[31], sel[0], sel[1], sel[2], sel[3], sel[4]);

endmodule 