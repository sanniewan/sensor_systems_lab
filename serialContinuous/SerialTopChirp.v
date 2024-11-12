module SerialTopChirp (
  input CLK_25MHZ,              // Main clock input (e.g., 25 MHz)
  input RSTN,               // Reset input
  input RXD,
  output [9:0] CH              // LED output
  output LEDR             // LED output

);


  reg [7:0] o_Rx_Byte;
  reg o_Rx_DV;
  reg [31:0] o_Rx_Four_Bytes; // = 25MHz / frequency
  // reg [9:0] CH;


  // uart_rx serial_data (.i_Clock(CLK_25MHZ), .i_Rx_Serial(RXD), .o_Rx_DV(o_Rx_DV), .o_Rx_Byte(o_Rx_Byte));

  four_byte_receiver_rx four_serial_data (.i_Clock(CLK_25MHZ), .i_Rx_Serial(RXD), .o_Rx_DV(o_Rx_DV), .o_Rx_Four_Bytes(o_Rx_Four_Bytes));

  // uart_tx sender (
  //   .i_Clock(CLK_25MHZ),
  //   .i_Tx_Byte(outgoing_tx_byte),
  //   .i_Tx_DV(senddata),
  //   .o_Tx_Active(o_Tx_Active),
  //   .o_Tx_Done(txdone),
  //   .o_Tx_Serial(TXD)
  // );

  reg [31:0] change_counter = 32'd0;
  reg [31:0] counter_target = 32'd0;  // counter counts to 25,000,000 / freq
  reg counter_on = 0;

  always @(posedge CLK_25MHZ or posedge RSTN) begin
    if (RSTN) begin
      // Reset all registers
      CH[0] <= 1'b0;
      LEDR <= 1'b0;

      counter_on <= 1'b0;
      change_counter <= 32'd0;
    end else begin
      
      if (o_Rx_DV) begin
          counter_target <= o_Rx_Four_Bytes;  // set target to the desired frequency value
          counter_on <= 0;
      end else begin

        // if (counter_on) begin

        // STATES:
        // LED: 0 or 1
        // change counter: >/< target
        // * if you want frequence of x counter_target should be 25000000/(2*freq)

        if(change_counter < counter_target) begin // LED does not change until time is up
          change_counter <= change_counter + 1;  // Increment the counter
        end else begin  // LED will change and counter will reset
          CH[0] <= ~CH[0];
          LEDR <= ~LEDR;

          change_counter <= 32'd0;      // Reset counter
        end
        // end else begin
        //   LEDR <= 1'b0;
        // end

      end
    end
  end

/*

*/

endmodule

// serial port for fpga (usually): /dev/cu.usbmodem143102
// list serial ports: $ ls /dev/tty.*