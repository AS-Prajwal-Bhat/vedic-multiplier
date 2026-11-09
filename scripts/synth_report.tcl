# Run this script inside an opened Vivado project:
#   source scripts/synth_report.tcl
#
# The selected part must match the actual FPGA on your board.
# This is a combinational circuit (no clock port), so a clock-period
# constraint is not applicable. Use I/O timing constraints only when
# the board/interface requirements are known.

synth_design -top vedic4x4 -part [get_property PART [current_project]]

file mkdir ./reports
report_utilization -file ./reports/vedic4x4_utilization.rpt
report_timing_summary -file ./reports/vedic4x4_timing_summary.rpt
report_power -file ./reports/vedic4x4_power.rpt

write_checkpoint -force ./reports/vedic4x4_synth.dcp
write_verilog -force -mode timesim ./reports/vedic4x4_synth_netlist.v

puts "Synthesis reports written to ./reports/"
puts "Note: power estimates are meaningful only with suitable activity and device assumptions."
