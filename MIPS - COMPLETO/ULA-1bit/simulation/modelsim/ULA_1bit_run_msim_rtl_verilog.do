transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/Thales/Desktop/ULA_Thales {C:/Users/Thales/Desktop/ULA_Thales/ULA_1bit.sv}
vlog -sv -work work +incdir+C:/Users/Thales/Desktop/ULA_Thales {C:/Users/Thales/Desktop/ULA_Thales/somador1bit.sv}
vlog -sv -work work +incdir+C:/Users/Thales/Desktop/ULA_Thales {C:/Users/Thales/Desktop/ULA_Thales/mux8.sv}
vlog -sv -work work +incdir+C:/Users/Thales/Desktop/ULA_Thales {C:/Users/Thales/Desktop/ULA_Thales/mux4.sv}
vlog -sv -work work +incdir+C:/Users/Thales/Desktop/ULA_Thales {C:/Users/Thales/Desktop/ULA_Thales/mux2.sv}

vlog -sv -work work +incdir+C:/Users/Thales/Desktop/ULA_Thales/testbench {C:/Users/Thales/Desktop/ULA_Thales/testbench/ULA_1bit_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneiv_hssi_ver -L cycloneiv_pcie_hip_ver -L cycloneiv_ver -L rtl_work -L work -voptargs="+acc"  ULA_1bit_tb

add wave *
view structure
view signals
run -all
