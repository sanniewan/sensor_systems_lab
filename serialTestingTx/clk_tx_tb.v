module clk_tx_tb;


    reg reset = 0;
    reg clk = 0;
    wire o_Clock;

    initial begin
        # 1 reset = 1;
        # 5 reset = 0;

        $dumpfile("clk_tx_tb.vcd");
        $dumpvars(0, clk_tx_tb);

        # 10000000 $finish;
        
    end

    always #1 clk = !clk;
    
    clk_tx clock (
        .reset(reset),
        .i_Clock(clk),
        .o_Clock(o_Clock)
    );


endmodule