package camera;
    import types::*;
    import trig::*;
    import math::*;
    import transform::*;

    class camera;
        transform t;

        function vec4 toscreencoords(vec4 vert, transform t);
            mat4 rotmat;
            // Rotate
            rotmat = t.rot.tomat4();
            vert = rotmat.mul_vec4(vert);

            // Translate
            vert.translate(t.pos);

            // vert.rotate(rot); // Rotate
            // vert.translate(); // Camera
            vert.perspective(rad(70), RESOLUTION_X / RESOLUTION_Y, 0.1, 100.0);

            return vert;
        endfunction
    endclass
endpackage