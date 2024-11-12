module ClockDivSerialTop (
  input CLK_25MHZ,              // Main clock input (e.g., 25 MHz)
  input RSTN,               // Reset input
  output LEDR              // LED output
);

  reg [31:0] freq_val; // New frequency value after change
  reg [31:0] FREQ_VAL1 = 32'd2500000; // New frequency value after change
  reg [31:0] FREQ_VAL2 = 32'd10000000; // Initial frequency value

  // assign freq_val = FREQ_VAL1;

  blink blinkie ( .freq_v(freq_val), .rst_s(RSTN), .clk_i(CLK_25MHZ), .led_o(LEDR) );

  reg [31:0] change_counter = 32'd0;

    always @(posedge CLK_25MHZ or posedge RSTN) begin
      if (RSTN) begin
          freq_val <= 32'b0;
      end
      else if (change_counter < 32'd25000000) begin // Example count to delay frequency change
        freq_val <= FREQ_VAL1;
        change_counter <= change_counter + 1;
      end
      else begin
        freq_val <= FREQ_VAL2;
      end
    end



endmodule

// serial port for fpga (usually): /dev/cu.usbmodem143102