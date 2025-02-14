library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Processador_tb is
end entity;

architecture a_Processador_tb of Processador_tb is
    component Processador is
        port(
            clk, rst : in std_logic;
            instrucao: out unsigned(15 downto 0);
            estado: out unsigned(1 downto 0);
            PC: out unsigned(15 downto 0);
            ULA_out,pin_out : out unsigned(15 downto 0)
    );
    end component;

    signal clk, rst :  std_logic;
    signal instrucao:  unsigned(15 downto 0);
    signal estado:  unsigned(1 downto 0);
    signal PC:  unsigned(15 downto 0);
    signal banco_out:  unsigned (15 downto 0);
    signal ULA_out,pin_out :  unsigned(15 downto 0);

    signal   finished    : std_logic := '0';
    constant period_time  : time := 100 ns;

begin
    uut: Processador port map(clk,rst,instrucao,estado,PC,ULA_out,pin_out);

    reset_global: process
    begin
        rst <= '1';
        wait for period_time*2;
        rst <= '0';
        wait;
    end process;

    sim_time_proc: process
    begin
        wait for 20000 us;
        finished <= '1';
        wait;
    end process sim_time_proc;

    clk_proc: process
    begin
        while finished /= '1' loop
            clk <= '0';
            wait for period_time/2;
            clk <= '1';
            wait for period_time/2;
        end loop;
        wait;
    end process clk_proc;

end architecture;