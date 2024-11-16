library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ROM_tb is 
end ROM_tb;

architecture a_ROM_tb of ROM_tb is
    component ROM is
        port( 
        clk      : in std_logic;
        endereco : in unsigned(6 downto 0);
        dado     : out unsigned(18 downto 0) 
        );
    end component;

    signal clk      : std_logic;
    signal endereco : unsigned(6 downto 0);
    signal dado     : unsigned(18 downto 0);

    signal   finished    : std_logic := '0';
    constant period_time  : time := 100 ns;


begin
    uut : ROM port map (clk,endereco,dado);

    process
    begin
        wait for period_time*2;
        endereco<="0000000";

        wait for period_time*2;
        endereco<="0000001";

        wait for period_time*2;
        endereco<="0000010";

        wait for period_time*2;
        endereco<="0000011";

        wait for period_time*2;
        endereco<="0000100";

        wait for period_time*2;
        endereco<="0000101";
        
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