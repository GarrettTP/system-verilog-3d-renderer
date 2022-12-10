# Use this run.do file to run this example.
# Either bring up ModelSim and type the following at the "ModelSim>" prompt:
#     do run.do
# or, to run from a shell, type the following at the shell prompt:
#     vsim -do run.do -c
# (omit the "-c" to see the GUI while running from the shell)

onbreak {resume}

# create library
if [file exists work] {
    vdel -all
}
vlib work

# compile source files
vlog math/trig.sv math/math.sv math/triangles.sv core/types.sv core/transform.sv core/camera.sv core/model.sv core/scene.sv core/geometric.sv core/partitions.sv core/physics.sv core/render.sv core/display.sv core/raytracer.sv core/clk.sv tb.sv +define+TESTBENCH

# start and run simulation
vsim -voptargs=+acc work.stimulus

view list
view wave

-- display input and output signals as hexidecimal values
# Diplays All Signals recursively
# add wave -hex -r /stimulus/*
add wave -noupdate -divider -height 32 "Game of Life"
# add wave -hex -r /stimulus/*
# add wave -hex -r /stimulus/*

# add list -hex -r /stimulus/*
# add log -r /*

-- Set Wave Output Items 
#TreeUpdate [SetDefaultTree]
#WaveRestoreZoom {0 ps} {75 ns}
#configure wave -namecolwidth 150
#configure wave -valuecolwidth 100
#configure wave -justifyvalue left
#configure wave -signalnamewidth 0
#configure wave -snapdistance 10
#configure wave -datasetprefix 0
#configure wave -rowmargin 4
#configure wave -childrowmargin 2

-- Run the Simulation
run 10000 ns

quit