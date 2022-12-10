package triangles;

    function real det2d(real p0_0, p0_1, p1_0, p1_1, p2_0, p2_1);
        return (
            p0_0*(p1_1-p2_1) + p1_0*(p2_1-p0_1) + p2_0*(p0_1-p1_1)
        );
    endfunction

    function byte boundcheck(real p0_0, p0_1, p1_0, p1_1, p2_0, p2_1, eps);
        return det2d(p0_0, p0_1, p1_0, p1_1, p2_0, p2_1) <= eps;
    endfunction

    function byte tricollision(
        real t0_0_0, t0_0_1, t0_1_0, t0_1_1, t0_2_0, t0_2_1, t1_0_0, t1_0_1, t1_1_0, t1_1_1, t1_2_0, t1_2_1
    );

        byte hit;
        
        // Check all points of triangle 2 lay on external side of edge
        if (boundcheck(t0_0_0, t0_0_1, t0_1_0, t0_1_1, t1_0_0, t1_0_1, 0.0)
            && boundcheck(t0_0_0, t0_0_1, t0_1_0, t0_1_1, t1_1_0, t1_1_1, 0.0)
            && boundcheck(t0_0_0, t0_0_1, t0_1_0, t0_1_1, t1_2_0, t1_2_1, 0.0))
            return 8'b0;

        if (boundcheck(t0_1_0, t0_1_1, t0_2_0, t0_2_1, t1_0_0, t1_0_1, 0.0)
            && boundcheck(t0_1_0, t0_1_1, t0_2_0, t0_2_1, t1_1_0, t1_1_1, 0.0)
            && boundcheck(t0_1_0, t0_1_1, t0_2_0, t0_2_1, t1_2_0, t1_2_1, 0.0))
            return 8'b0;

        if (boundcheck(t0_2_0, t0_2_1, t0_0_0, t0_0_1, t1_0_0, t1_0_1, 0.0)
            && boundcheck(t0_2_0, t0_2_1, t0_0_0, t0_0_1, t1_1_0, t1_1_1, 0.0)
            && boundcheck(t0_2_0, t0_2_1, t0_0_0, t0_0_1, t1_2_0, t1_2_1, 0.0))
            return 8'b0;

        // Check all points of triangle 1 lay on external side of edge
        if (boundcheck(t1_0_0, t1_0_1, t1_1_0, t1_1_1, t0_0_0, t0_0_1, 0.0)
            && boundcheck(t1_0_0, t1_0_1, t1_1_0, t1_1_1, t0_1_0, t0_1_1, 0.0)
            && boundcheck(t1_0_0, t1_0_1, t1_1_0, t1_1_1, t0_2_0, t0_2_1, 0.0))
            return 8'b0;

        if (boundcheck(t1_1_0, t1_1_1, t1_2_0, t1_2_1, t0_0_0, t0_0_1, 0.0)
            && boundcheck(t1_1_0, t1_1_1, t1_2_0, t1_2_1, t0_1_0, t0_1_1, 0.0)
            && boundcheck(t1_1_0, t1_1_1, t1_2_0, t1_2_1, t0_2_0, t0_2_1, 0.0))
            return 8'b0;

        if (boundcheck(t1_2_0, t1_2_1, t1_0_0, t1_0_1, t0_0_0, t0_0_1, 0.0)
            && boundcheck(t1_2_0, t1_2_1, t1_0_0, t1_0_1, t0_1_0, t0_1_1, 0.0)
            && boundcheck(t1_2_0, t1_2_1, t1_0_0, t1_0_1, t0_2_0, t0_2_1, 0.0))
            return 8'b0;

        return 8'b1;
    endfunction

    function real sign(real p0_0, p0_1, p1_0, p1_1, p2_0, p2_1);
        return (p0_0-p2_0) * (p1_1-p2_1) - (p1_0-p2_0) * (p0_1-p2_1);
    endfunction

    function byte pointcollision(real t0_0, t0_1, t1_0, t1_1, t2_0, t2_1, px, py);
        real d1, d2, d3;
        byte hasneg, haspos;

        d1 = sign(px, py, t0_0, t0_1, t1_0, t1_1);
        d2 = sign(px, py, t1_0, t1_1, t2_0, t2_1);
        d3 = sign(px, py, t2_0, t2_1, t0_0, t0_1);

        hasneg = (d1 < 0.0) || (d2 < 0.0) || (d3 < 0.0);
        haspos = (d1 > 0.0) || (d2 > 0.0) || (d3 > 0);
        
        return !(hasneg && haspos);
    endfunction

endpackage