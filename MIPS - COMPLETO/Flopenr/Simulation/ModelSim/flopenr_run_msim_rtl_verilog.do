transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/aluno/Desktop/Flopenr {C:/Users/aluno/Desktop/Flopenr/flopenr.sv}

vlog -sv -work work +incdir+C:/Users/aluno/Desktop/Flopenr/Testbench {C:/Users/aluno/Desktop/Flopenr/Testbench/flopenr_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc" flopenr_tb

add wave *
view structure
view signals
run -all
