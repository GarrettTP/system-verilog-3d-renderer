`include "math.sv"

module stimulus();
    vec4 pos;
    vec4 trans;
    vec4 rot;

    vec4 out;

    initial begin
        pos = new(0.0, 5.0, -10.0);
        rot = new(`PI/2.0, `PI/4.0, 0.0);

        $display("%.2f", fmod(-`PI*1.5, `PI));

        // pos.rotate(rot);
        pos.perspective(rad(70), 1.0, 0.1, 100.0);
        
        $display(pos.tostr());
        $display("Cos(3.14159) = %.2f", cos(`PI*1.5));
    end


endmodule