module SerialTopTxTb;

  reg reset = 0;
  reg clk = 0;
  wire o_Tx_Active;
  wire txdone;
  wire TXD;
  reg senddata;
  reg [7:0] outgoing_tx_byte = 8'b00011001;
  reg [31:0] delay_counter;

  initial begin
     #0 reset = 1;
     #10 reset = 0;  // Hold reset for 10 time units
     $dumpfile("serialTopTx.vcd");
     $dumpvars(0, SerialTopTxTb);
     #100000 $finish;
  end

  // Generate clock with 1 time unit period
  always #1 clk = !clk;

  // Instantiate the UART TX module
  // uart_tx2 serial_data_tx (
  //   .i_Clock(clk),
  //   .i_Tx_Byte(outgoing_tx_byte),
  //   .i_Tx_DV(senddata),
  //   .o_Tx_Active(o_Tx_Active),
  //   .o_Tx_Done(txdone),
  //   .o_Tx_Serial(TXD)
  // );

  uart_tx serial_data_tx (
    .clk(clk),
    .txbyte(outgoing_tx_byte),
    .senddata(senddata),
    .txdone(txdone),
    .tx(TXD)
  );


  always @(posedge clk or posedge reset) begin
    if (reset) begin
      // Reset all registers
      senddata <= 1'b0;
      delay_counter <= 32'd0;  // Reset delay counter
    end else begin
      // Check if delay has reached 4 (for simulation purposes)
      if (delay_counter >= 32'd4) begin
        senddata <= 1'b1;       // Trigger data send
        delay_counter <= 32'd0; // Reset the counter
      end else begin
        senddata <= 1'b0;
        delay_counter <= delay_counter + 1; // Increment the delay counter
      end

      // Check if transmission is done
      if (txdone) begin
        delay_counter <= 32'd0;
        senddata <= 1'b0;  // Clear senddata after transmission is complete
      end
    end
  end
endmodule
