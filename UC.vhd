library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity UC is
    port(
        clk, rst : in std_logic
    );
end entity;

architecture a_UC of UC is
    component PC is
        port( 
            clk, rst : in std_logic;
            estado: in unsigned (1 downto 0);
            endereco: out unsigned(6 downto 0)
        );
    end component;

    component ROM is
        port( 
            clk      : in std_logic;
            endereco : in unsigned(6 downto 0);
            dado     : out unsigned(18 downto 0) 
        );
    end component;

    component MaqEst is
        port(
            clk, rst: in std_logic;
            estado: out unsigned(1 downto 0)
        );
    end component;
    
    signal wren_PC : std_logic;
    signal PC_out, PC_in, jump_end : unsigned(15 downto 0);
    signal MaqEst_out : unsigned(1 downto 0);
    signal endereco_ROM : unsigned(6 downto 0);
    signal instrucao : unsigned(18 downto 0);
    signal opcode : unsigned(2 downto 0);


    constant zero_16bits  : unsigned(15 downto 0) := "0000000000000000";


begin

    UC_PC : PC
    port map(
        clk => clk,
        rst => rst,
        estado => MaqEst_out,
        endereco => endereco_ROM
    );

    UC_ROM : ROM
    port map (
        clk => clk,
        endereco => endereco_rom,
        dado => instrucao
    );

    UC_MaqEst : MaqEst
    port map (
        clk => clk,
        rst => rst,
        estado => MaqEst_out
    );

end architecture;