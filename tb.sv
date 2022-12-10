import trig::*;
import math::*;

import model::*;
import scene::*;
import camera::*;

module stimulus();
    bit sysclk;
    bit update;

    model m1;
    scene myscene;
    camera cam;

    vec3 v;

    initial begin
        // Set vertices for cube
        m1 = new({
            -1.0,-1.0,-1.0, // triangle 1 : begin
            -1.0,-1.0, 1.0,
            -1.0, 1.0, 1.0, // triangle 1 : end
            1.0, 1.0,-1.0, // triangle 2 : begin
            -1.0,-1.0,-1.0,
            -1.0, 1.0,-1.0, // triangle 2 : end
            1.0,-1.0, 1.0,
            -1.0,-1.0,-1.0,
            1.0,-1.0,-1.0,
            1.0, 1.0,-1.0,
            1.0,-1.0,-1.0,
            -1.0,-1.0,-1.0,
            -1.0,-1.0,-1.0,
            -1.0, 1.0, 1.0,
            -1.0, 1.0,-1.0,
            1.0,-1.0, 1.0,
            -1.0,-1.0, 1.0,
            -1.0,-1.0,-1.0,
            -1.0, 1.0, 1.0,
            -1.0,-1.0, 1.0,
            1.0,-1.0, 1.0,
            1.0, 1.0, 1.0,
            1.0,-1.0,-1.0,
            1.0, 1.0,-1.0,
            1.0,-1.0,-1.0,
            1.0, 1.0, 1.0,
            1.0,-1.0, 1.0,
            1.0, 1.0, 1.0,
            1.0, 1.0,-1.0,
            -1.0, 1.0,-1.0,
            1.0, 1.0, 1.0,
            -1.0, 1.0,-1.0,
            -1.0, 1.0, 1.0,
            1.0, 1.0, 1.0,
            -1.0, 1.0, 1.0,
            1.0,-1.0, 1.0
        });

        // Set position
        m1.t.pos = new(0.0, 0.0, -5.0);

        // Set rotation
        v = new(1.0, 0.0, 0.0);
        m1.t.rot = angleaxis(rad(45.0), v);

        // Set color
        m1.color = {0, 150, 250};

        // Set angular velocity
        m1.angvel = angleaxis(rad(1.0), v);

        cam = new();

        myscene = new();
        myscene.cam = cam;
        myscene.fillcolor = {255, 0, 0};

        myscene.addmodels({
            m1
        });
    end

    raytracer rt(sysclk, myscene);

    always_ff @(posedge update) begin
        $display("FRAME %d", $time);
    end

    initial begin
        forever #1 sysclk = ~sysclk;
    end
endmodule