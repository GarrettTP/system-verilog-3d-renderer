A custom 3D render written in SystemVerilog capable of ultra basic rendering operations.

# system-verilog-3d-renderer

This SystemVerilog project renders basic 3D geometry. No external code, libraries, rendering engines, graphics frameworks, etc, are used within the SystemVerilog code. The idea was to make the code synthesizable on an fpga board, but the board I had access to did not have enough memory to create a pixel buffer or depth buffer without an external device. The goal of this project is to demonstrate complex mathematical concepts used in rendering pipelines and an understanding of non-synthesizable SystemVerilog coding techniques.

# How it Works
Images are rendered frame by frame into .tga files. The chosen image type was .tga due to the simplistic image encoding and header. Once each frame is rendered from SystemVerilog, a Python utility consolidates the images into a single video.avi file.

## Issues
The project is not complete and still has some bugs such as clipping at the edges of triangles and lacks a depth buffer.

## Example Render

![video](https://user-images.githubusercontent.com/59297404/206822728-d5aeb21d-1354-4bda-b929-9f358c94aa48.gif)
