transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/rafae/Desktop/Projetos-CECI/Projetos-CECI/MIPS/Datapath {C:/Users/rafae/Desktop/Projetos-CECI/Projetos-CECI/MIPS/Datapath/Datapath.sv}
vlog -sv -work work +incdir+C:/Users/rafae/Desktop/Projetos-CECI/Projetos-CECI/MIPS/Datapath {C:/Users/rafae/Desktop/Projetos-CECI/Projetos-CECI/MIPS/Datapath/registradorenreset.sv}
vlog -sv -work work +incdir+C:/Users/rafae/Desktop/Projetos-CECI/Projetos-CECI/MIPS/Datapath {C:/Users/rafae/Desktop/Projetos-CECI/Projetos-CECI/MIPS/Datapath/mux2.sv}
vlog -sv -work work +incdir+C:/Users/rafae/Desktop/Projetos-CECI/Projetos-CECI/MIPS/Datapath {C:/Users/rafae/Desktop/Projetos-CECI/Projetos-CECI/MIPS/Datapath/registradorreset.sv}
vlog -sv -work work +incdir+C:/Users/rafae/Desktop/Projetos-CECI/Projetos-CECI/MIPS/Datapath {C:/Users/rafae/Desktop/Projetos-CECI/Projetos-CECI/MIPS/Datapath/mux2_5bits.sv}
vlog -sv -work work +incdir+C:/Users/rafae/Desktop/Projetos-CECI/Projetos-CECI/MIPS/Datapath {C:/Users/rafae/Desktop/Projetos-CECI/Projetos-CECI/MIPS/Datapath/bancoregistradores.sv}
vlog -sv -work work +incdir+C:/Users/rafae/Desktop/Projetos-CECI/Projetos-CECI/MIPS/Datapath {C:/Users/rafae/Desktop/Projetos-CECI/Projetos-CECI/MIPS/Datapath/decoder.sv}
vlog -sv -work work +incdir+C:/Users/rafae/Desktop/Projetos-CECI/Projetos-CECI/MIPS/Datapath {C:/Users/rafae/Desktop/Projetos-CECI/Projetos-CECI/MIPS/Datapath/mux32.sv}
vlog -sv -work work +incdir+C:/Users/rafae/Desktop/Projetos-CECI/Projetos-CECI/MIPS/Datapath {C:/Users/rafae/Desktop/Projetos-CECI/Projetos-CECI/MIPS/Datapath/mux8.sv}
vlog -sv -work work +incdir+C:/Users/rafae/Desktop/Projetos-CECI/Projetos-CECI/MIPS/Datapath {C:/Users/rafae/Desktop/Projetos-CECI/Projetos-CECI/MIPS/Datapath/mux4.sv}
vlog -sv -work work +incdir+C:/Users/rafae/Desktop/Projetos-CECI/Projetos-CECI/MIPS/Datapath {C:/Users/rafae/Desktop/Projetos-CECI/Projetos-CECI/MIPS/Datapath/signalextension.sv}
vlog -sv -work work +incdir+C:/Users/rafae/Desktop/Projetos-CECI/Projetos-CECI/MIPS/Datapath {C:/Users/rafae/Desktop/Projetos-CECI/Projetos-CECI/MIPS/Datapath/shifter2.sv}
vlog -sv -work work +incdir+C:/Users/rafae/Desktop/Projetos-CECI/Projetos-CECI/MIPS/Datapath {C:/Users/rafae/Desktop/Projetos-CECI/Projetos-CECI/MIPS/Datapath/ula32bits.sv}
vlog -sv -work work +incdir+C:/Users/rafae/Desktop/Projetos-CECI/Projetos-CECI/MIPS/Datapath {C:/Users/rafae/Desktop/Projetos-CECI/Projetos-CECI/MIPS/Datapath/ula1bit.sv}
vlog -sv -work work +incdir+C:/Users/rafae/Desktop/Projetos-CECI/Projetos-CECI/MIPS/Datapath {C:/Users/rafae/Desktop/Projetos-CECI/Projetos-CECI/MIPS/Datapath/somador1bit.sv}
vlog -sv -work work +incdir+C:/Users/rafae/Desktop/Projetos-CECI/Projetos-CECI/MIPS/Datapath {C:/Users/rafae/Desktop/Projetos-CECI/Projetos-CECI/MIPS/Datapath/mux8_1bit.sv}
vlog -sv -work work +incdir+C:/Users/rafae/Desktop/Projetos-CECI/Projetos-CECI/MIPS/Datapath {C:/Users/rafae/Desktop/Projetos-CECI/Projetos-CECI/MIPS/Datapath/mux4_1bit.sv}
vlog -sv -work work +incdir+C:/Users/rafae/Desktop/Projetos-CECI/Projetos-CECI/MIPS/Datapath {C:/Users/rafae/Desktop/Projetos-CECI/Projetos-CECI/MIPS/Datapath/mux2_1bit.sv}

vlog -sv -work work +incdir+C:/Users/rafae/Desktop/Projetos-CECI/Projetos-CECI/MIPS/Datapath/testbench {C:/Users/rafae/Desktop/Projetos-CECI/Projetos-CECI/MIPS/Datapath/testbench/Datapath_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  Datapath_tb

add wave *
view structure
view signals
run -all
