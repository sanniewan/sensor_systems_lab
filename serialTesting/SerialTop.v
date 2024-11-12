module SerialTop (
  input CLK_25MHZ,              // Main clock input (e.g., 25 MHz)
  input RSTN,               // Reset input
  input RXD,
  output LEDR              // LED output
);


  reg [7:0] o_Rx_Byte;
  reg o_Rx_DV;
  reg [31:0] o_Rx_Four_Bytes;


  // uart_rx serial_data (.i_Clock(CLK_25MHZ), .i_Rx_Serial(RXD), .o_Rx_DV(o_Rx_DV), .o_Rx_Byte(o_Rx_Byte));
  four_byte_receiver_rx four_serial_data (.i_Clock(CLK_25MHZ), .i_Rx_Serial(RXD), .o_Rx_DV(o_Rx_DV), .o_Rx_Four_Bytes(o_Rx_Four_Bytes));
  

  reg [31:0] change_counter = 32'd0;
  reg counter_on = 0;


  always @(posedge CLK_25MHZ or posedge RSTN) begin
    if (RSTN) begin
      // Reset all registers
      LEDR <= 1'b0;
      counter_on <= 1'b0;
      change_counter <= 32'd0;
    end else begin
      if (o_Rx_DV) begin

        if (o_Rx_Four_Bytes == 32'd25000000) begin  // Check if received byte is correct
          counter_on <= 1'b1;           // Start the counter
          change_counter <= 32'd0;      // Reset counter
          LEDR <= 1'b1;                 // Turn on the LED
        end else begin
          counter_on <= 1'b0;
          change_counter <= 32'd0;
          LEDR <= 1'b0;
        end
      end else if (counter_on) begin
        if (change_counter < 32'd6250000) begin  // If within 1/4 second duration
          change_counter <= change_counter + 1;  // Increment the counter
        end else begin
          // Turn off the LED and stop counting after 1/4 second
          LEDR <= 1'b0;
          counter_on <= 1'b0;
        end
      end else begin
        LEDR <= 1'b0;  // Keep the LED off by default
      end
    end
  end



endmodule

// serial port for fpga (usually): /dev/cu.usbmodem143102
// list serial ports: $ ls /dev/tty.*