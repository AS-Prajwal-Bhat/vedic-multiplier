# Run from the project root:
#   vivado -mode batch -source scripts/run_sim.tcl
#
# Uses xvlog/xelab/xsim through Vivado's Tcl commands.

set rtl_files [list \
    [file normalize "./rtl/vedic2x2.v"] \
    [file normalize "./rtl/vedic4x4.v"] \
]
set tb_file [file normalize "./sim/vedic4x4_tb.v"]

file mkdir ./sim_build
cd ./sim_build

foreach f $rtl_files {
    read_verilog $f
}
read_verilog -sv $tb_file
set_property top vedic4x4_tb [current_fileset]
launch_simulation -mode behavioral
run all
close_sim
