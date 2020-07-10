transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/rafae/Desktop/Projetos-CECI/MIPS/multiplexadores/Sem_Parameter/mux2_5bits {C:/Users/rafae/Desktop/Projetos-CECI/MIPS/multiplexadores/Sem_Parameter/mux2_5bits/mux2_5bits.sv}

vlog -sv -work work +incdir+C:/Users/rafae/Desktop/Projetos-CECI/MIPS/multiplexadores/Sem_Parameter/mux2_5bits/testbench {C:/Users/rafae/Desktop/Projetos-CECI/MIPS/multiplexadores/Sem_Parameter/mux2_5bits/testbench/mux2_5bits_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  mux2_5bits_tb

add wave *
view structure
view signals
run -all
