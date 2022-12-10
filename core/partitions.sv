package partitions;
    import math::*;
    import triangles::*;
    import scene::*;
    import types::*;
    import model::*;

    int PARTITIONS = 100;

    class partition;
        int indices[];
        int counter;

        function new();
            this.counter = 0;
            this.indices = new[2];
        endfunction

        function void addindices(int model, t);
            if (counter >= this.indices.size()) begin
                this.indices = new[this.indices.size() * 2] (this.indices);
            end

            this.indices[counter] = model;
            this.indices[counter+1] = t;

            counter += 2;
        endfunction
    endclass

    class partition_map;
        partition partitions[];

        function new();
            this.partitions = new[PARTITIONS * PARTITIONS];
        endfunction

        function void loadscene(scene _scene, int frame);
            real c;

            // #tri_#vertex_#dimension (x/y)
            real t0_0_0, t0_0_1, t0_1_0, t0_1_1, t0_2_0, t0_2_1;
            real t1_0_0, t1_0_1, t1_1_0, t1_1_1, t1_2_0, t1_2_1;

            real psize = 1.0/PARTITIONS;
            model m;

            bit collision;

            // Initialize partitions
            partition p;
            for (int i = 0; i < this.partitions.size(); i++) begin
                p = new();
                this.partitions[i] = p;
            end

            for (int x = 0; x < PARTITIONS; x++) begin
                for (int y = 0; y < PARTITIONS; y++) begin
                    // Must be counter-clockwise
                    t0_0_0 = psize*x * 2.0 - 1.0;
                    t0_0_1 = psize*y * 2.0 - 1.0;
                    t0_1_0 = psize*(x+1) * 2.0 - 1.0;
                    t0_1_1 = psize*y * 2.0 - 1.0;
                    t0_2_0 = psize*x * 2.0 - 1.0;
                    t0_2_1 = psize*(y+1) * 2.0 - 1.0;

                    t1_0_0 = psize*(x+1) * 2.0 - 1.0;
                    t1_0_1 = psize*y * 2.0 - 1.0;
                    t1_1_0 = psize*x * 2.0 - 1.0;
                    t1_1_1 = psize*(y+1) * 2.0 - 1.0;
                    t1_2_0 = psize*(x+1) * 2.0 - 1.0;
                    t1_2_1 = psize*(y+1) * 2.0 - 1.0;

                    for (int i = 0; i < _scene.models.size(); i++) begin
                        m = _scene.models[i];

                        for (int j = 0; j < m.rcache.screencoords.size(); j+=9) begin
                            collision = tricollision(
                                t0_0_0, t0_0_1, t0_1_0, t0_1_1, t0_2_0, t0_2_1,
                                m.rcache.screencoords[j+0], m.rcache.screencoords[j+1], m.rcache.screencoords[j+3],
                                m.rcache.screencoords[j+4], m.rcache.screencoords[j+6], m.rcache.screencoords[j+7]
                            ) | tricollision(
                                t1_0_0, t1_0_1, t1_1_0, t1_1_1, t1_2_0, t1_2_1,
                                m.rcache.screencoords[j+0], m.rcache.screencoords[j+1], m.rcache.screencoords[j+3],
                                m.rcache.screencoords[j+4], m.rcache.screencoords[j+6], m.rcache.screencoords[j+7]
                            );

                            if (collision) begin
                                this.partitions[y*PARTITIONS + x].addindices(i, j);
                            end
                        end
                    end
                end
            end
        endfunction
    endclass
endpackage