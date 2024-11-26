library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PC_tb is
end entity;

architecture a_PC_tb of PC_tb is
    component PC is
        port(
            clk, rst : in std_logic;
            estado: in unsigned (1 downto 0);
            endereco: out unsigned(6 downto 0)
        );
    end component;

    signal clk, rst : std_logic;
    signal estado: unsigned (1 downto 0);
    signal endereco: unsigned(6 downto 0);

    signal   finished    : std_logic := '0';
    constant period_time  : time := 100 ns;

begin
    uut: PC port map(clk, rst, estado, endereco);

    process
    begin
        estado <= "01";
        wait for period_time*2;
        estado <= "00";
        wait for period_time*2;
        estado <= "01";
        wait for period_time*2;
        estado <= "00";
        wait;        
    end process;

    reset_global: process
    begin
        rst <= '1';
        wait for period_time*2;
        rst <= '0';
        wait;
    end process;

    sim_time_proc: process
    begin
        wait for 10 us;
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