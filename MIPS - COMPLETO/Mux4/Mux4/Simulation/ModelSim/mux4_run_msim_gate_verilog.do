transcript on
if {[file exists gate_work]} {
	vdel -lib gate_work -all
}
vlib gate_work
vmap work gate_work

vlog -vlog01compat -work work +incdir+. {mux4.vo}

vlog -sv -work work +incdir+C:/Users/Thales/Desktop/FLOPSMUX/Mux4/Mux4/Testbench {C:/Users/Thales/Desktop/FLOPSMUX/Mux4/Mux4/Testbench/mux4_tb.sv}

vsim -t 1ps +transport_int_delays +transport_path_delays -L altera_ver -L cycloneive_ver -L gate_work -L work -voptargs="+acc"  mux4_tb

add wave *
view structure
view signals
run -all
