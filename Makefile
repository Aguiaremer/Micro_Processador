UUT = ROM

all: clear ULA Reg BancoReg ULAeBanco ROM

clear:
	@del work-obj93.cf

test: 
	@ghdl -a $(UUT)_tb.vhd
	@ghdl -e $(UUT)_tb
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

ULAeBanco:
	@ghdl -a ULAeBanco.vhd
	@ghdl -e ULAeBanco

ROM:
	@ghdl -a ROM.vhd
	@ghdl -e ROM
