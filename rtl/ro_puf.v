`timescale 1ns/1ps

// Parameterized gated ring oscillator for behavioral simulation.
// N counts the total inversion stages: one NAND plus N-1 inverters.
// Use odd N values only (3, 5, 7, 11, ...).
module ro_puf #(
    parameter integer N = 7,
    parameter integer STAGE_DELAY = 1
)(
    input  ena,
    output ro_out
);
    (* KEEP="TRUE" *)
    (* DONT_TOUCH="TRUE" *)

    wire [N-1:0] stage;

    // Stage 0 is the gated NAND feedback stage.
    assign #(STAGE_DELAY) stage[0] = ~(ena & stage[N-1]);

    // Stages 1 through N-1 are inverters.
    genvar i;
    generate
        for (i = 1; i < N; i = i + 1) begin : inverter_stages
            assign #(STAGE_DELAY) stage[i] = ~stage[i-1];
        end
    endgenerate

    assign ro_out = stage[N-1];

endmodule
