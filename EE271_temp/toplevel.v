// Top-level module that defines the I/Os for the DE-1 SoC board
module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
output logic [9:0] LEDR;
input logic [3:0] KEY;
input logic [9:0] SW;
lights lab3(.U(SW[0]), .P(SW[1]),.C(SW[2]), .i_mark(SW[3]), .o_disc(LEDR[0]), .o_stole(LEDR[1]));
display hex (
    .U(SW[0]), 
    .P(SW[1]), 
    .C(SW[2]), 
    .HEX0(HEX0), 
    .HEX1(HEX1), 
    .HEX2(HEX2), 
    .HEX3(HEX3), 
    .HEX4(HEX4), 
    .HEX5(HEX5)
);
assign LEDR[0] = o_disc;
assign LEDR[1] = o_stole;

endmodule

/*
module lab3 (
  input U,
  input P,
  input C,
  input i_mark,
  output o_disc,
  output o_stole
);

*/