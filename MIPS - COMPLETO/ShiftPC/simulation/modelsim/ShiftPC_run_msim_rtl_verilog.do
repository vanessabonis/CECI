transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/Thales/Desktop/ShiftPC {C:/Users/Thales/Desktop/ShiftPC/ShiftPC.sv}

vlog -sv -work work +incdir+C:/Users/Thales/Desktop/ShiftPC/testbench {C:/Users/Thales/Desktop/ShiftPC/testbench/ShiftPC_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneiv_hssi_ver -L cycloneiv_pcie_hip_ver -L cycloneiv_ver -L rtl_work -L work -voptargs="+acc"  ShiftPC_tb

add wave *
view structure
view signals
run -all
