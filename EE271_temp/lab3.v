module lab3 (
  input U,
  input P,
  input C,
  input i_mark,
  output o_disc,
  output o_stole
);

assign o_disc = (U && C) || (U && P);
assign o_stole = (!P && !C && !i_mark) || (U && !P && !M);

endmodule