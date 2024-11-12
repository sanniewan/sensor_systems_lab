module ClockDivSerialTb;

  /* Make a reset that pulses once. */
  reg reset = 0;


  // One-bit output
  wire clk_out;
  
  // Frequency value for the clock divider
  reg [31:0] freq_val;

  initial begin
     $dumpfile("clockDivMod_test.vcd");
     $dumpvars(0,ClockDivSerialTb);
     // Initial frequency value
     freq_val = 4;

     # 17 reset = 1;
     # 100 reset = 1;
     # 100 freq_val = 9;
     
     # 29 reset = 1;
     # 5  reset = 0;
     
     # 513 $finish;
  end


  /* Make a regular pulsing clock. */
  reg clk = 0;
  always #1 clk = !clk;

     
  // Instance of clockDivMod
  clockDivMod clk_div_inst (
    .FREQ_VAL(freq_val),
    .reset(reset),
    .clk_in(clk),
    .clk_out(clk_out)
  );

  initial
     $monitor("At time %t, clk_out = %h (%0d)",
              $time, clk_out, clk_out);

endmodule