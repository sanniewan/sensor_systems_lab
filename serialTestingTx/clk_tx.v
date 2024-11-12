module clk_tx (
  parameter CLKS_PER_BIT = 4
)(
    input reset
    input i_Clock,
    output o_Clock
);

  reg [31:0] counter = 32'd0;      // 32-bit counter for delay

  always @(posedge i_Clock or posedge reset) begin
    if (reset) begin
        counter <= 32'd0;
        o_Clock <= 1'b0;
    end else begin
        if (counter >= CLKS_PER_BIT) begin
            counter <= 32'd0;
            o_Clock <= ~o_Clock;
        end else begin
            counter <= counter + 1;
        end
    end
  end
endmodule