try:
    import cv2
    import numpy as np
    import glob
    from PIL import Image
except ImportError as e:
    print("Pillow is required to convert tga files to png. Run 'pip install --upgrade Pillow' and retry.")
    print("OpenCV is required to generate video. Run 'pip install opencv-python' and retry.")
    exit()

import os

print("Converting renders")

# Convert renders to .jpg
directory = "../renders"
for filename in os.listdir(directory):
    f = os.path.join(directory, filename)
    if os.path.isfile(f):
        path, ext = os.path.splitext(f)
        if ext == ".tga":
            im = Image.open(f)
            im.save(path + ".png")
            os.remove(f)

print("Generating video")

# Create video
frameSize = (1080, 1080)

out = cv2.VideoWriter('../video.avi', cv2.VideoWriter_fourcc(*'DIVX'), 60, frameSize)

frame = 1
for filename in os.listdir(directory):
    f = "../renders/frame" + str(frame) + ".png"
    frame += 1

    if os.path.isfile(f):
        img = cv2.imread(f)
        out.write(img)

out.release()

print("Done")