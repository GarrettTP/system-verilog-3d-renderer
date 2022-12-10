package geometric;
    import math::*;
    import scene::*;
    import camera::*;
    import transform::*;
    import model::*;

    function void transform_scene(scene _scene);
        model m;
        rendercache r;
        vec4 v0, v1, v2;
        vec4 sv0, sv1, sv2;

        for (int i = 0; i < _scene.models.size(); i++) begin
            m = _scene.models[i];
            r = new(m.vertices.size());
            
            for (int j = 0; j < m.vertices.size(); j+=9) begin
                v0 = new(m.vertices[j+0], m.vertices[j+1], m.vertices[j+2]);
                v1 = new(m.vertices[j+3], m.vertices[j+4], m.vertices[j+5]);
                v2 = new(m.vertices[j+6], m.vertices[j+7], m.vertices[j+8]);

                sv0 = _scene.cam.toscreencoords(v0, m.t);
                sv1 = _scene.cam.toscreencoords(v1, m.t);
                sv2 = _scene.cam.toscreencoords(v2, m.t);

                r.screencoords[j+0] = sv0.x;
                r.screencoords[j+1] = sv0.y;
                r.screencoords[j+2] = sv0.z;
                r.screencoords[j+3] = sv1.x;
                r.screencoords[j+4] = sv1.y;
                r.screencoords[j+5] = sv1.z;
                r.screencoords[j+6] = sv2.x;
                r.screencoords[j+7] = sv2.y;
                r.screencoords[j+8] = sv2.z;
            end

            m.rcache = r;
        end
    endfunction

endpackage