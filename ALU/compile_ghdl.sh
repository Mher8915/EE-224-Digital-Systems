cd Traces
python generate_adder.py
python generate_subtractor.py
python generate_left_shift.py
python generate_right_shift.py
python generate_alu.py
cd ..
# All GHDL files
ghdl -a *.vhd
ghdl -m Testbench_Adder
ghdl -m Testbench_Subtractor
ghdl -m Testbench_Left_Shift
ghdl -m Testbench_Right_Shift
ghdl -m Testbench_ALU