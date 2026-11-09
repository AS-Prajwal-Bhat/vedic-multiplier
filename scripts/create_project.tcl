set PROJECT_NAME "Vedic_Multiplier"
set PROJECT_DIR  [file normalize "./vivado_project"]
set PART         "xc7a35tcpg236-1"

create_project $PROJECT_NAME $PROJECT_DIR -part $PART -force
set_property target_language Verilog [current_project]
set_property simulator_language Mixed [current_project]

add_files [list \
    [file normalize "./rtl/vedic2x2.v"] \
    [file normalize "./rtl/vedic4x4.v"] \
]

add_files -fileset sim_1 [list \
    [file normalize "./sim/vedic4x4_tb.v"] \
]

set_property top vedic4x4 [current_fileset]
set_property top vedic4x4_tb [get_filesets sim_1]

update_compile_order -fileset sources_1
update_compile_order -fileset sim_1

puts "Project created at: $PROJECT_DIR"
puts "Selected FPGA part: $PART"
puts "RTL top: vedic4x4"
puts "Simulation top: vedic4x4_tb"
puts "Open the project in Vivado and run Run Simulation > Run Behavioral Simulation."
