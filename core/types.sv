`define RESOLUTION_X 1080
`define RESOLUTION_Y 1080

package types;
    int RESOLUTION_X = `RESOLUTION_X;
    int RESOLUTION_Y = `RESOLUTION_Y;

    typedef byte pixelbuffer[`RESOLUTION_X*`RESOLUTION_Y*3];
endpackage