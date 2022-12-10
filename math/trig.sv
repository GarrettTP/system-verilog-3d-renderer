package trig;
    const real PI = 3.1415926535;

    // Handles negative numbers
    function real fmod(input real x, y);
        real mul;

        mul = x < 0 ? -1.0 : 1.0;
        return x - y*mul * $floor(x*mul / y);
    endfunction

    // Taylor's expansion
    function real sin(input real x);
        x = fmod(x, PI);
        return x - x**3/6 + x**5/120 - x**7/5040 + x**9/362880;
    endfunction

    function real cos(input real x);
        x = fmod(x, PI);
        return 1 - x**2/2 + x**4/24 - x**6/720 + x**8/40320;
    endfunction

    function real tan(input real x);
        return sin(x) / cos(x);
    endfunction

    function real rad(input real x);
        return x/180*PI;
    endfunction

endpackage