module four_byte_receiver_rx (
  input            i_Clock,          // Main clock
  input            i_Rx_Serial,      // Serial input (RX)
  output reg [31:0] o_Rx_Four_Bytes, // Output: 32-bit value from 4 received bytes (little endian)
  output reg       o_Rx_DV           // Data Valid signal
);

  // State machine for receiving four bytes
  parameter s_IDLE      = 2'b00;
  parameter s_RECEIVING = 2'b01;
  parameter s_DONE      = 2'b10;

  reg [1:0] r_SM_Main = s_IDLE;
  reg [1:0] r_Byte_Count = 0;   // Counter to keep track of the number of received bytes
  reg [31:0] r_Rx_Data = 32'd0; // Register to hold the 32-bit data temporarily
  
  // UART RX signals
  wire       w_Rx_DV;
  wire [7:0] w_Rx_Byte;

  

  // UART RX module instantiation
  uart_rx #(.CLKS_PER_BIT(217)) uart_rx_inst (
    .i_Clock(i_Clock),
    .i_Rx_Serial(i_Rx_Serial),
    .o_Rx_DV(w_Rx_DV),
    .o_Rx_Byte(w_Rx_Byte)
  );

  always @(posedge i_Clock) begin
    case (r_SM_Main)
      s_IDLE: begin
        o_Rx_DV <= 1'b0;
        if (w_Rx_DV) begin // When a byte is received
          r_Rx_Data[7:0] <= w_Rx_Byte; // Store the first byte (least significant)
          r_Byte_Count <= 2'd1;
          r_SM_Main <= s_RECEIVING;
        end
      end

      s_RECEIVING: begin
        if (w_Rx_DV) begin
          r_Byte_Count <= r_Byte_Count + 1;
          case (r_Byte_Count)
            2'd1: r_Rx_Data[15:8]  <= w_Rx_Byte; // Store the second byte
            2'd2: r_Rx_Data[23:16] <= w_Rx_Byte; // Store the third byte
            2'd3: begin
              r_Rx_Data[31:24] <= w_Rx_Byte; // Store the fourth byte
              r_SM_Main <= s_DONE;           // Move to DONE state
            end
          endcase
        end
      end

      s_DONE: begin
        o_Rx_Four_Bytes <= r_Rx_Data; // Output the 32-bit data
        o_Rx_DV <= 1'b1;              // Set the data valid flag
        r_Byte_Count <= 2'd0;         // Reset the byte counter
        r_SM_Main <= s_IDLE;          // Go back to IDLE state
      end

      default: r_SM_Main <= s_IDLE;
    endcase
  end
endmodule