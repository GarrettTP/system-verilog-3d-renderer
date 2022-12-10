package physics;
    import math::*;
    import transform::*;
    import model::*;
    import scene::*;

    function void physicsstep(scene _scene, real t);
        model m;
        vec4 newpos;
        quaternion newrot;

        for (int i = 0; i < _scene.models.size(); i++) begin
            m = _scene.models[i];

            newrot = m.t.rot;
            newrot.mul_quat(m.angvel);
            m.t.rot = newrot;

            newpos = new(m.t.pos.x + m.vel.x*t, m.t.pos.y + m.vel.y*t, m.t.pos.z + m.vel.z*t);
            m.t.pos = newpos;
        end

    endfunction

endpackage