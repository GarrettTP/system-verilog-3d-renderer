package model;
    import math::*;
    import transform::*;

    class rendercache;
        real screencoords[];

        function new(int buffersize);
            screencoords = new[buffersize];
        endfunction
    endclass

    class model;
        real vertices[];
        byte color[3];

        transform t;

        vec4 vel;
        quaternion angvel;

        rendercache rcache;
        
        function new(real vertices[]);
            this.vertices = vertices;

            this.vel = new(0, 0, 0);
            this.angvel = new(0, 0, 0, 0);
            this.t = new();
        endfunction
    endclass

    
endpackage