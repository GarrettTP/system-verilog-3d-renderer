package scene;
    import camera::*;
    import model::*;

    class scene;
        model models[];
        camera cam;

        int fillcolor[3];

        function new();
            this.models = new[0];
        endfunction

        function void addmodels(model models[]);
            int prevsize = this.models.size();
            this.models = new[prevsize + models.size()](this.models);

            for (int i = 0; i < models.size(); i++) begin
                this.models[prevsize + i] = models[i];
            end
        endfunction

        function void setcamera(camera cam);
            this.cam = cam;
        endfunction
    endclass
endpackage