transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/Thales/Desktop/CECI_MIPS/bancoRegistradores {C:/Users/Thales/Desktop/CECI_MIPS/bancoRegistradores/decoder.sv}
vlog -sv -work work +incdir+C:/Users/Thales/Desktop/CECI_MIPS/bancoRegistradores {C:/Users/Thales/Desktop/CECI_MIPS/bancoRegistradores/flopenr.sv}
vlog -sv -work work +incdir+C:/Users/Thales/Desktop/CECI_MIPS/bancoRegistradores {C:/Users/Thales/Desktop/CECI_MIPS/bancoRegistradores/inversor.sv}
vlog -sv -work work +incdir+C:/Users/Thales/Desktop/CECI_MIPS/bancoRegistradores {C:/Users/Thales/Desktop/CECI_MIPS/bancoRegistradores/mux2.sv}
vlog -sv -work work +incdir+C:/Users/Thales/Desktop/CECI_MIPS/bancoRegistradores {C:/Users/Thales/Desktop/CECI_MIPS/bancoRegistradores/mux4.sv}
vlog -sv -work work +incdir+C:/Users/Thales/Desktop/CECI_MIPS/bancoRegistradores {C:/Users/Thales/Desktop/CECI_MIPS/bancoRegistradores/mux32.sv}
vlog -sv -work work +incdir+C:/Users/Thales/Desktop/CECI_MIPS/bancoRegistradores {C:/Users/Thales/Desktop/CECI_MIPS/bancoRegistradores/tristate.sv}
vlog -sv -work work +incdir+C:/Users/Thales/Desktop/CECI_MIPS/bancoRegistradores {C:/Users/Thales/Desktop/CECI_MIPS/bancoRegistradores/bancoRegistradores.sv}

vlog -sv -work work +incdir+C:/Users/Thales/Desktop/CECI_MIPS/bancoRegistradores/testbench {C:/Users/Thales/Desktop/CECI_MIPS/bancoRegistradores/testbench/bancoRegistradores_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneiv_hssi_ver -L cycloneiv_pcie_hip_ver -L cycloneiv_ver -L rtl_work -L work -voptargs="+acc"  bancoRegistradores_tb

add wave *
view structure
view signals
run -all
