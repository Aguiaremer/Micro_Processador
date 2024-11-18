library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity UC is
    port(
        clk, rst : in std_logic
    );
end entity;

architecture a_UC of UC is
    component Reg16bits is
        port( 
            clk, wr_en, rst : in std_logic;
            data_in  : in unsigned(15 downto 0);
            data_out : out unsigned(15 downto 0)
        );
    end component;

    component ROM is
        port( 
            clk      : in std_logic;
            endereco : in unsigned(6 downto 0);
            dado     : out unsigned(18 downto 0) 
        );
    end component;

    component MaqEst_1bit is
        port(
            clk, rst : in std_logic;
            estado : out std_logic
        );
    end component;
    
    signal MaqEst_out, wren_PC : std_logic;
    signal PC_out, PC_in, jump_end : unsigned(15 downto 0);
    signal endereco_ROM : unsigned(6 downto 0);
    signal instrucao : unsigned(18 downto 0);
    signal opcode : unsigned(2 downto 0);


    constant zero_16bits  : unsigned(15 downto 0) := "0000000000000000";


begin

    PC : Reg16bits
    port map(
        clk => clk,
        rst => rst,
        wr_en => wren_PC,
        data_in => pc_in,
        data_out => pc_out
    );

    UC_ROM : ROM
    port map (
        clk => clk,
        endereco => endereco_rom,
        dado => instrucao
    );

    UC_MaqEst : MaqEst_1bit
    port map (
        clk => clk,
        rst => rst,
        estado => MaqEst_out
    );

    opcode <= instrucao(2 downto 0);
    jump_end <= instrucao(18 downto 3);

    wren_PC <=  '1' when MaqEst_out = '0' else '0';
    PC_in <=    "0000000000000000"  when rst = '1'                              else
                pc_out + 1          when MaqEst_out = '1' and opcode = "000"    else
                jump_end            when MaqEst_out = '1' and opcode = "001";

    endereco_rom <= pc_out(6 downto 0);
end architecture;