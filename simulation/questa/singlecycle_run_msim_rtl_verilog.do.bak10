transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/TUAN/tailieuhocbk/nam4ki1/Do_an_1/RISC_Vsinglecycle {C:/Users/TUAN/tailieuhocbk/nam4ki1/Do_an_1/RISC_Vsinglecycle/branch_comb.sv}
vlog -sv -work work +incdir+C:/Users/TUAN/tailieuhocbk/nam4ki1/Do_an_1/RISC_Vsinglecycle {C:/Users/TUAN/tailieuhocbk/nam4ki1/Do_an_1/RISC_Vsinglecycle/lsu.sv}
vlog -sv -work work +incdir+C:/Users/TUAN/tailieuhocbk/nam4ki1/Do_an_1/RISC_Vsinglecycle {C:/Users/TUAN/tailieuhocbk/nam4ki1/Do_an_1/RISC_Vsinglecycle/regfile.sv}
vlog -sv -work work +incdir+C:/Users/TUAN/tailieuhocbk/nam4ki1/Do_an_1/RISC_Vsinglecycle {C:/Users/TUAN/tailieuhocbk/nam4ki1/Do_an_1/RISC_Vsinglecycle/alu.sv}
vlog -sv -work work +incdir+C:/Users/TUAN/tailieuhocbk/nam4ki1/Do_an_1/RISC_Vsinglecycle {C:/Users/TUAN/tailieuhocbk/nam4ki1/Do_an_1/RISC_Vsinglecycle/immgen.sv}
vlog -sv -work work +incdir+C:/Users/TUAN/tailieuhocbk/nam4ki1/Do_an_1/RISC_Vsinglecycle {C:/Users/TUAN/tailieuhocbk/nam4ki1/Do_an_1/RISC_Vsinglecycle/alu_control.sv}
vlog -sv -work work +incdir+C:/Users/TUAN/tailieuhocbk/nam4ki1/Do_an_1/RISC_Vsinglecycle {C:/Users/TUAN/tailieuhocbk/nam4ki1/Do_an_1/RISC_Vsinglecycle/control_unit.sv}
vlog -sv -work work +incdir+C:/Users/TUAN/tailieuhocbk/nam4ki1/Do_an_1/RISC_Vsinglecycle {C:/Users/TUAN/tailieuhocbk/nam4ki1/Do_an_1/RISC_Vsinglecycle/mux3to1.sv}
vlog -sv -work work +incdir+C:/Users/TUAN/tailieuhocbk/nam4ki1/Do_an_1/RISC_Vsinglecycle {C:/Users/TUAN/tailieuhocbk/nam4ki1/Do_an_1/RISC_Vsinglecycle/singlecycle.sv}
vlog -sv -work work +incdir+C:/Users/TUAN/tailieuhocbk/nam4ki1/Do_an_1/RISC_Vsinglecycle {C:/Users/TUAN/tailieuhocbk/nam4ki1/Do_an_1/RISC_Vsinglecycle/program_counter.sv}
vlog -sv -work work +incdir+C:/Users/TUAN/tailieuhocbk/nam4ki1/Do_an_1/RISC_Vsinglecycle {C:/Users/TUAN/tailieuhocbk/nam4ki1/Do_an_1/RISC_Vsinglecycle/instmemory.sv}

vlog -sv -work work +incdir+C:/Users/TUAN/tailieuhocbk/nam4ki1/Do_an_1/RISC_Vsinglecycle {C:/Users/TUAN/tailieuhocbk/nam4ki1/Do_an_1/RISC_Vsinglecycle/singlecycle_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  singlecycle_tb

add wave *
view structure
view signals
run -all
