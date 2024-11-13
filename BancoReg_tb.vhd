library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity BancoReg_tb is
end BancoReg_tb;

architecture a_BancoReg_tb of BancoReg_tb is
    component BancoReg is
        port (
        wr_en, clk, rst : in std_logic;
        reg_selec : in unsigned(3 downto 0);
        data_write : in   unsigned(15 downto 0);
        data_reg : out unsigned(15 downto 0)
        );
    end component;

    signal wr_en, clk, rst : std_logic;
    signal reg_selec : unsigned(3 downto 0);
    signal data_write, data_reg : unsigned(15 downto 0);

    signal   finished    : std_logic := '0';
    constant period_time  : time := 100 ns;

begin
    uut : BancoReg port map(wr_en, clk, rst, reg_selec, data_write, data_reg);

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

    process
    begin
        wait for period_time*2;
        reg_selec<="0001";
        data_write<="0000000000000001";
        wr_en<='1';
        wait for period_time*2;
        wr_en<='0';
        wait for period_time*2;
        data_write<="0000000000000000";
        wait for period_time*2;
        data_write<="0000000000000001";
        wr_en<='1';
        reg_selec<="0010";
        wait;
    end process;
end architecture;