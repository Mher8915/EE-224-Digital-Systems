ghdl -a *.vhd
ghdl -m Testbench
./testbench --stop-time=1000000ns --vcd=run.vcd