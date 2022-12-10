`define SIMULATE_FRAMES 300

import types::*;
import renderer::*;
import display::*;
import scene::*;
import partitions::*;
import geometric::*;
import physics::*;

module raytracer(sysclk, _scene);
    input bit sysclk;
    input scene _scene;

    int frame;

    typedef enum bit [2:0] {
        START, // MSB
        GEOMETRIC_TRANSFORM,
        FILL_PARTITIONS,
        RENDER,
        PHYSICS,
        DISPLAY,
        FINISH // LSB
    } sys_step;

    sys_step step, nextstep;

    // Set up frame clock @ 60fps
    bit frameclk;
    frame_clk clk(sysclk, frameclk);

    partition_map partitionmap;
    pixelbuffer image;

    // Start engine steps for the next frame
    always_ff @(posedge sysclk) begin
        step = frameclk ? START : nextstep;
    end

    // Each frame run through one step per clock cycle
    always_comb begin
        case(step)
            START: begin
                nextstep = GEOMETRIC_TRANSFORM;
                frame++;

                // Reset partition map
                partitionmap = new();
            end
            GEOMETRIC_TRANSFORM: begin
                transform_scene(_scene);

                nextstep = FILL_PARTITIONS;
            end
            FILL_PARTITIONS: begin
                partitionmap.loadscene(_scene, frame);

                nextstep = RENDER;
            end
            RENDER: begin
                image = render(_scene, partitionmap, frame);

                nextstep = PHYSICS;
            end
            PHYSICS: begin
                physicsstep(_scene, 1.0/60.0);

                nextstep = DISPLAY;
            end
            DISPLAY: begin
                tgadisplay(frame, image);

                nextstep = FINISH;
            end
            FINISH: begin
                `ifdef TESTBENCH if (frame == `SIMULATE_FRAMES) $finish; `endif
            end
        endcase
    end

endmodule