transcript on
if {[file exists gate_work]} {
	vdel -lib gate_work -all
}
vlib gate_work
vmap work gate_work

vlog -vlog01compat -work work +incdir+. {mux2.vo}

vlog -sv -work work +incdir+C:/Users/Thales/Desktop/FLOPSMUX/Mux2/Testbench {C:/Users/Thales/Desktop/FLOPSMUX/Mux2/Testbench/mux2_tb.sv}

vsim -t 1ps +transport_int_delays +transport_path_delays -L altera_ver -L cycloneive_ver -L gate_work -L work -voptargs="+acc"  mux2_tb

add wave *
view structure
view signals
run -all
