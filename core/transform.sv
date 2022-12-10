package transform;
    import math::*;

    class transform;
        vec4 pos;
        quaternion rot;

        function new();
            pos = new(0, 0, 0);
            rot = new(0, 0, 0, 0);
        endfunction
    endclass

endpackage