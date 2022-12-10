package renderer;
    import types::*;
    import partitions::*;
    import scene::*;
    import triangles::*;
    import model::*;

    function pixelbuffer render(scene _scene, partition_map partitionmap, int frame);
        pixelbuffer image;

        partition p;
        int parx, pary; // Partition x & y
        real rx, ry, px, py; // Real x & y, point coordinates x & y

        int color[3];
        int depth;

        model m;
        real p0_x, p0_y, p0_z, p1_x, p1_y, p1_z, p2_x, p2_y, p2_z;

        for (int x = 0; x < RESOLUTION_X; x++) begin
            rx = x;
            px = rx / RESOLUTION_X * 2.0 - 1.0;
            parx = $floor((rx / RESOLUTION_X) * PARTITIONS);

            for (int y = 0; y < RESOLUTION_Y; y++) begin
                ry = y;
                py = ry / RESOLUTION_Y * 2.0 - 1.0;
                pary = $floor((ry / RESOLUTION_Y) * PARTITIONS);

                p = partitionmap.partitions[pary*PARTITIONS + parx];

                depth = 0; /////////// TODO
                for (int i = 0; i < p.counter; i+=2) begin
                    m = _scene.models[p.indices[i]];
                    
                    p0_x = m.rcache.screencoords[p.indices[i+1] + 0];
                    p0_y = m.rcache.screencoords[p.indices[i+1] + 1];
                    p0_z = m.rcache.screencoords[p.indices[i+1] + 2];
                    p1_x = m.rcache.screencoords[p.indices[i+1] + 3];
                    p1_y = m.rcache.screencoords[p.indices[i+1] + 4];
                    p1_z = m.rcache.screencoords[p.indices[i+1] + 5];
                    p2_x = m.rcache.screencoords[p.indices[i+1] + 6];
                    p2_y = m.rcache.screencoords[p.indices[i+1] + 7];
                    p2_z = m.rcache.screencoords[p.indices[i+1] + 8];

                    if (pointcollision(p0_x, p0_y, p1_x, p1_y, p2_x, p2_y, px, py)) begin
                        depth = 1;
                    end
                end

                if (depth == 1) begin
                    image[y*RESOLUTION_Y*3 + x*3 + 0] = m.color[2];
                    image[y*RESOLUTION_Y*3 + x*3 + 1] = m.color[1];
                    image[y*RESOLUTION_Y*3 + x*3 + 2] = m.color[0];
                end
                else begin
                    image[y*RESOLUTION_Y*3 + x*3 + 0] = _scene.fillcolor[2];
                    image[y*RESOLUTION_Y*3 + x*3 + 1] = _scene.fillcolor[1];
                    image[y*RESOLUTION_Y*3 + x*3 + 2] = _scene.fillcolor[0];
                end
                
            end
        end

        return image;
    endfunction

endpackage