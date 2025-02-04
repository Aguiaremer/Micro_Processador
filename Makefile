UUT = Processador

all: clear ULA Reg16bits Reg1bits BancoReg ULAeBanco ROM MaqEst UC RAM Processador

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

Reg16bits:
	@ghdl -a Reg16bits.vhd
	@ghdl -e Reg16bits

Reg1bits:
	@ghdl -a Reg1bits.vhd
	@ghdl -e Reg1bits

BancoReg:
	@ghdl -a BancoReg.vhd
	@ghdl -e BancoReg

ULAeBanco:
	@ghdl -a ULAeBanco.vhd
	@ghdl -e ULAeBanco

ROM:
	@ghdl -a ROM.vhd
	@ghdl -e ROM

MaqEst:
	@ghdl -a MaqEst.vhd
	@ghdl -e MaqEst

UC: 
	@ghdl -a UC.vhd
	@ghdl -e UC

Processador:
	@ghdl -a Processador.vhd
	@ghdl -e Processador

RAM:
	@ghdl -a RAM.vhd
	@ghdl -e RAM

