UUT = ULA

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

ULA:
	@ghdl -a ULA.vhd
	@ghdl -e ULA

Reg:
	@ghdl -a Reg16bits.vhd
	@ghdl -e Reg16bits

BancoReg:
	@ghdl -a BancoReg.vhd
	@ghdl -e BancoReg