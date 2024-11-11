UUT = regs

all: component testbench view

component:
	@ghdl -a $(UUT).vhd
	@ghdl -e $(UUT)

testbench:
	@ghdl -a $(UUT)_tb.vhd
	@ghdl -e $(UUT)_tb

view:
	@ghdl -r $(UUT)_tb --wave=$(UUT).ghw
	@gtkwave $(UUT).ghw