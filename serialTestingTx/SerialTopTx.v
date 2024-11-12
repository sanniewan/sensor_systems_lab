module SerialTopTx (
  input CLK_25MHZ,              // Main clock input (e.g., 25 MHz)
  input RSTN,                   // Reset input (active high)
  input RXD,                    // UART RX input
  output TXD,                   // UART TX output
);

  wire txdone;                   // Signal indicating transmission is done
  wire o_Tx_Active;

  reg senddata;                  // Trigger signal to send data
  reg [7:0] outgoing_tx_byte = 8'd99;    // Byte to transmit

  // Counter for generating 2-second delay
  reg [31:0] delay_counter;      // 32-bit counter for delay
  
  // Instantiate the UART RX module (not needed for transmitting only, but included for completeness)
  // uart_rx serial_data (
  //   .i_Clock(CLK_25MHZ),
  //   .i_Rx_Serial(RXD),
  //   .o_Rx_DV(),               // Not used in this example
  //   .o_Rx_Byte()              // Not used in this example
  // );

  // Instantiate the UART TX module
  uart_tx2 serial_data_tx (
    .i_Clock(CLK_25MHZ),
    .i_Tx_Byte(outgoing_tx_byte),
    .i_Tx_DV(senddata),
    .o_Tx_Active(o_Tx_Active),
    .o_Tx_Done(txdone),
    .o_Tx_Serial(TXD)
  );

  // uart_tx serial_data_tx (
  //   .clk(CLK_25MHZ),
  //   .txbyte(outgoing_tx_byte),
  //   .senddata(senddata),
  //   .txdone(txdone),
  //   .tx(TXD)
  // );

  /*
    clk,        // input clock
    txbyte,     // outgoing byte
    senddata,   // trigger tx
    txdone,     // outgoing byte sent
    tx,         // tx wire
  */

  /*
   input       i_Clock,
   input       i_Tx_DV,
   input [7:0] i_Tx_Byte, 
   output      o_Tx_Active,
   output reg  o_Tx_Serial,
   output      o_Tx_Done
  */

  // 15:  0b000001111
  // 25:  0b000011001
  // 26:  0b000011010
  // 100: 0b01100100
  // 266: 0b100001010

  always @(posedge CLK_25MHZ or posedge RSTN) begin
    if (RSTN) begin
      // Reset all registers
      senddata <= 1'b0;
      delay_counter <= 32'd0;  // Reset delay counter
    end else begin
      if (delay_counter == 32'd25000000) begin
        senddata <= 1'b1;
        delay_counter <= 32'd0;
      end else begin
        senddata <= 1'b0;
        delay_counter <= delay_counter + 1;
      end
    //   // Check if delay has reached 4 (for simulation purposes)
    //   if (delay_counter >= 32'd50000000) begin
    //     senddata <= 1'b1;       // Trigger data send
    //     delay_counter <= 32'd0; // Reset the counter
    //   end else begin
    //     senddata <= 1'b0;
    //     delay_counter <= delay_counter + 1; // Increment the delay counter
    //   end

    //   // Check if transmission is done
    //   if (txdone) begin
    //     delay_counter <= 32'd0;
    //     senddata <= 1'b0;  // Clear senddata after transmission is complete
    //   end
    end
  end

endmodule