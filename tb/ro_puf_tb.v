`timescale 1ns/1ps

module ro_puf_tb;

    reg ena;
    wire ro_out;

    ro_puf #(.N(7)) dut (
        .ena(ena),
        .ro_out(ro_out)
    );

    initial begin
        ena = 1'b0;
        #10;

        ena = 1'b1;
        #100;

        ena = 1'b0;
        #10;

        $finish;
    end

endmodule
