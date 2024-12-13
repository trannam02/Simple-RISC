# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
set_param synth.incrementalSynthesisCache C:/Users/NAM/AppData/Roaming/Xilinx/Vivado/.Xil/Vivado-17120-nam/incrSyn
set_param xicom.use_bs_reader 1
set_msg_config -id {Synth 8-256} -limit 10000
set_msg_config -id {Synth 8-638} -limit 10000
create_project -in_memory -part xc7z020clg400-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir C:/Users/NAM/RISC/RISC.cache/wt [current_project]
set_property parent.project_path C:/Users/NAM/RISC/RISC.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property board_part digilentinc.com:arty-z7-20:part0:1.1 [current_project]
set_property ip_output_repo c:/Users/NAM/RISC/RISC.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_mem C:/Users/NAM/RISC/RISC.srcs/sim_1/new/output.mem
read_verilog -library xil_defaultlib {
  C:/Users/NAM/RISC/RISC.srcs/sources_1/new/ALU.v
  C:/Users/NAM/RISC/RISC.srcs/sources_1/new/bufferNbits.v
  C:/Users/NAM/RISC/RISC.srcs/sources_1/new/clock_divider.v
  C:/Users/NAM/RISC/RISC.srcs/sources_1/new/controller.v
  C:/Users/NAM/RISC/RISC.srcs/sources_1/new/counterNbits.v
  C:/Users/NAM/RISC/RISC.srcs/sources_1/new/memory32x8_bi.v
  C:/Users/NAM/RISC/RISC.srcs/sources_1/new/muxNbits.v
  C:/Users/NAM/RISC/RISC.srcs/sources_1/new/registerNbits.v
  C:/Users/NAM/RISC/RISC.srcs/sources_1/new/registerNbits_neg.v
  C:/Users/NAM/RISC/RISC.srcs/sources_1/new/cpu.v
}
# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc C:/Users/NAM/RISC/xdc_files/Arty-Z7-20-Master.xdc
set_property used_in_implementation false [get_files C:/Users/NAM/RISC/xdc_files/Arty-Z7-20-Master.xdc]

set_param ips.enableIPCacheLiteLoad 0
close [open __synthesis_is_running__ w]

synth_design -top cpu -part xc7z020clg400-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef cpu.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file cpu_utilization_synth.rpt -pb cpu_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
