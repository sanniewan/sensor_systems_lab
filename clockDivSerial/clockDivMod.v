module clockDivMod (
  input [31:0] FREQ_VAL,   // 32-bit input
  input reset,
  input clk_in,            // 1-bit clock input
  output reg clk_out       // 1-bit clock output
);

  reg [31:0] counter = 0;          // 32-bit counter
  reg [31:0] freq_val;         // 32-bit storage for FREQ_VAL


  always @(posedge clk_in or posedge reset) begin
    if (reset) begin
          counter <= FREQ_VAL/2;
          clk_out <= 1'b0;
        end
        else begin
          if (counter == FREQ_VAL) begin
            counter <= 1'b0;
            clk_out <= ~clk_out;    // Toggle the output clock
          end else begin
            clk_out <= clk_out;  // explicit
            counter <= counter + 1;
        end
        end
  end

endmodule

