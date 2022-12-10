`define SYS_CLK_SPEED 125000000 // 125Mhz
`define FPS 60

module frame_clk(sysclk, update);
    input logic sysclk;
    output bit update;
    int step;

    `ifdef TESTBENCH
        initial begin
            forever #20 update = ~update;
        end
    `else
        always_ff @( posedge sysclk ) begin
            if (step == `SYS_CLK_SPEED / `FPS) begin
                step = 0;
                update = 1'b1;
            end
            else begin
                step++;
                update = 1'b0;
            end
        end
    `endif
endmodule