transcript on
if {[file exists gate_work]} {
	vdel -lib gate_work -all
}
vlib gate_work
vmap work gate_work

vlog -sv -work work +incdir+. {mux2_min_1200mv_0c_fast.svo}

vlog -sv -work work +incdir+C:/Users/rafae/Desktop/Projetos-CECI/MIPS/multiplexadores/Sem_Parameter/mux2/testbench {C:/Users/rafae/Desktop/Projetos-CECI/MIPS/multiplexadores/Sem_Parameter/mux2/testbench/mux2_tb.sv}

vsim -t 1ps +transport_int_delays +transport_path_delays -L altera_ver -L cycloneive_ver -L gate_work -L work -voptargs="+acc"  mux2_tb

add wave *
view structure
view signals
run -all
