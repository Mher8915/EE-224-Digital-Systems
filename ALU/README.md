# Arithmetic Logic Unit - VHDL
Use the bash script compile_ghdl.sh to compile all VHDL files. A testbench has been created for each and every component of the ALU. One could run executable testbenches using
`./testbench_alu --stop-time=1000000ns --vcd=run.vcd`
and see the waveforms on,
`gtkwave run.vcd`
