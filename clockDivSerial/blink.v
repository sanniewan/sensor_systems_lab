// module blink (
//     input      freq_v,
//     input      rst_s,
//     input      clk_i,
//     output reg led_o
// );
// reg [31:0] MAX = freq_v;
// reg [31:0] WIDTH = $clog2(MAX);

// // wire rst_s;
// wire clk_s;

// assign clk_s = clk_i;
// //pll_12_16 pll_inst (.clki(clk_i), .clko(clk_s), .rst(rst_s));
// // rst_gen rst_inst (.clk_i(clk_s), .rst_i(1'b0), .rst_o(rst_s));

// reg  [31:0] cpt_s;
// wire [31:0] cpt_next_s = cpt_s + 1'b1;

// wire             end_s = cpt_s == MAX-1;

// always @(posedge clk_s) begin
//     cpt_s <= (rst_s || end_s) ? {WIDTH{1'b0}} : cpt_next_s;

//     if (rst_s)
//         led_o <= 1'b0;
//     else if (end_s)
//         led_o <= ~led_o;
// end
// endmodule

module blink (
    input      clk_i,        // Clock input
    input      rst_s,        // Reset input
    input [31:0] freq_v,     // Frequency input
    output reg led_o         // LED output
);

localparam WIDTH = $clog2(32'hFFFFFFFF);  // Maximum width needed for 32-bit values

reg [31:0] cpt_s;   // Counter register
reg [31:0] MAX = freq_v;     // Maximum count value derived from freq_v
wire [31:0] cpt_next_s = cpt_s + 1'b1; // Next counter value

wire end_s = (cpt_s == MAX-1);  // End of counter

always @(posedge clk_i) begin
    if (end_s) begin
        cpt_s <= 32'b0;        // Reset counter at end
        led_o <= ~led_o;       // Toggle LED
    end else begin
        cpt_s <= cpt_next_s;   // Increment counter
    end
end

endmodule
