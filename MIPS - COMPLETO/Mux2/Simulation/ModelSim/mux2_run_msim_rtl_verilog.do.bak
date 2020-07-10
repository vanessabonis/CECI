transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/aluno/Desktop/Entrega\ 2/Mux2 {C:/Users/aluno/Desktop/Entrega 2/Mux2/inversor.sv}
vlog -sv -work work +incdir+C:/Users/aluno/Desktop/Entrega\ 2/Mux2 {C:/Users/aluno/Desktop/Entrega 2/Mux2/tristate.sv}
vlog -sv -work work +incdir+C:/Users/aluno/Desktop/Entrega\ 2/Mux2 {C:/Users/aluno/Desktop/Entrega 2/Mux2/mux2.sv}

vlog -sv -work work +incdir+C:/Users/aluno/Desktop/Entrega\ 2/Mux2/Testbench {C:/Users/aluno/Desktop/Entrega 2/Mux2/Testbench/mux2_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc" mux2_tb

add wave *
view structure
view signals
run -all
