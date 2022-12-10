package display;
    import types::*;

    function void tgadisplay(int frame, pixelbuffer image);
        string fname;
        int imgf;
        
        // Get file handle
        $sformat(fname, "renders/frame%0d.tga", frame);
        imgf = $fopen(fname, "wb");

        // .tga header
        $fwrite(imgf, "%c", 0);                      // Length of image id field
        $fwrite(imgf, "%c", 0);                      // No color map
        $fwrite(imgf, "%c", 2);                      // Image type (truecolor no-encoding)
        $fwrite(imgf, "%c%c%c%c%c", 0, 0, 0, 0, 0);  // Colormap specification
        $fwrite(imgf, "%c%c", 0, 0);                 // X offset
        $fwrite(imgf, "%c%c", 0, 0);                 // Y offset
        $fwrite(imgf, "%c%c", RESOLUTION_X[7:0], RESOLUTION_X[15:8]); // Width
        $fwrite(imgf, "%c%c", RESOLUTION_Y[7:0], RESOLUTION_Y[15:8]); // Height
        $fwrite(imgf, "%c", 24);                     // Pixel depth; bits per pixel
        $fwrite(imgf, "%c", 8'b00100000);             // Image descriptor; set image origin to top left corner

        for (int x = 0; x < RESOLUTION_X; x++) begin
            for (int y = 0; y < RESOLUTION_Y; y++) begin
                $fwrite(
                    imgf, "%c%c%c",
                    image[y*RESOLUTION_Y*3 + x*3 + 0],
                    image[y*RESOLUTION_Y*3 + x*3 + 1],
                    image[y*RESOLUTION_Y*3 + x*3 + 2]
                );
            end
        end

        $fclose(imgf);
    endfunction
endpackage