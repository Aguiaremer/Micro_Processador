library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MaqEst_1bit_tb is
end entity;

architecture a_MaqEst_1bit_tb of MaqEst_1bit_tb is
    component MaqEst_1bit is
        port(
            clk, rst : in std_logic;
            estado : out std_logic
        );
    end component;

    signal clk, rst : std_logic;
    signal estado : std_logic;

    signal   finished    : std_logic := '0';
    constant period_time  : time := 100 ns;

begin
    uut: MaqEst_1bit port map (clk,rst,estado);
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