library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PC is
    port(
        clk, rst : in std_logic;
        estado: in unsigned (1 downto 0);
        endereco: out unsigned(6 downto 0)
    );
end entity;

architecture a_PC of PC is
    component Reg16bits is
        port(
            clk, wr_en, rst : in std_logic;
            data_in  : in unsigned(15 downto 0);
            data_out : out unsigned(15 downto 0)
        );
    end component;

    signal enable_wr : std_logic;
    signal entrada, saida : unsigned(15 downto 0);

begin
    PC_reg : Reg16bits
    port map(
        clk => clk,
        rst => rst,
        wr_en => enable_wr,
        data_in => entrada,
        data_out => saida
    );

    entrada <= saida + 1;
    enable_wr <= '1' when estado="01" else '0';

    endereco <= saida(6 downto 0);
end architecture;