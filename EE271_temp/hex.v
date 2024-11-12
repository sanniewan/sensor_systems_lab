module lab3 (U, P, C, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);

    // Define the 7-segment display outputs for HEX0 through HEX5
    output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
    
    // Define inputs U, P, and C
    input U;
    input P;
    input C;
    
    // Declare internal wires or registers to hold the 6-bit values for each HEX display
    reg [6:0] display0, display1, display2, display3, display4, display5;

    // Define logic to generate different 7-bit values based on the inputs (U, P, C)
    always_comb begin
        // Set display0 - display5 based on binary combinations of U, P, and C

        // Example: Combine U, P, C into a 3-bit number and drive the displays
        case ({U, P, C})
            3'b000: begin
                display0 = 7'b1011011;  // SHOES in binary
                display1 = 7'b0110111;
                display2 = 7'b1111110;
                display3 = 7'b1001111;
                display4 = 7'b1011011;
                display5 = 7'b0;
            end
            3'b001: begin
                display0 = 7'b1011110;  // 7 in binary
                display1 = 7'b0001110;  // 8 in binary
                display2 = 7'b1001111;  // 9 in binary
                display3 = 7'b1001111;  // 10 in binary
                display4 = 7'b0;  // 11 in binary
                display5 = 7'b0;  // 12 in binary
            end
            3'b010: begin
                display0 = 7'b1111111;  // 13 in binary
                display1 = 7'b1110111;  // 14 in binary
                display2 = 7'b0001110;  // 15 in binary
                display3 = 7'b0001110;  // 16 in binary
                display4 = 7'b1011011;  // 17 in binary
                display5 = 7'b0;  // 18 in binary
            end
            3'b100: begin
                display0 = 7'b1001110;
                display1 = 7'b0111110;
                display2 = 7'b1000111;
                display3 = 7'b1000111;
                display4 = 7'b0;
                display5 = 7'b0;
            end
            3'b101: begin
                // Another set of values (you can modify as needed)
                display0 = 7'b1000111;
                display1 = 7'b0111110;
                display2 = 7'b1101101;
                display3 = 7'b1101101;
                display4 = 7'b0;
                display5 = 7'b0;
            end
            3'b111: begin
                // Final combination of values
                display0 = 7'b1011011;
                display1 = 7'b1111110;
                display2 = 7'b1001110;
                display3 = 7'b0110111;
                display4 = 7'b1011011;
                display5 = 7'b0;
            end
            default: begin
                // Default case, can assign default values
                display0 = 7'b000000;
                display1 = 7'b000000;
                display2 = 7'b000000;
                display3 = 7'b000000;
                display4 = 7'b000000;
                display5 = 7'b000000;
            end
        endcase
    end
    
    // Connect the 6-bit values to the corresponding HEX displays
    assign HEX0 = !display0[6:0];
    assign HEX1 = !display1[6:0];
    assign HEX2 = !display2[6:0];
    assign HEX3 = !display3[6:0];
    assign HEX4 = !display4[6:0];
    assign HEX5 = !display5[6:0];

endmodule