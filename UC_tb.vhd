
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity UC_tb is
end entity;

architecture a_UC_tb of UC_tb is
    component UC is 
        port(
            clk, rst, f_carry, f_zero : in std_logic;
            opcode_ULA: out unsigned (1 downto 0);
            reg_selec: out unsigned (3 downto 0);
            instrucao, const: out unsigned(15 downto 0);
            estado: out unsigned(1 downto 0);
            PC: out unsigned(15 downto 0);
            wr_enBanco, wr_enAcumulador, MOV_R_A, MOV_A_R, soma_acumulador : out std_logic
        );
    end component;

    signal clk, rst, f_carry, f_zero :  std_logic;
    signal opcode_ULA:  unsigned (1 downto 0);
    signal reg_selec:  unsigned (3 downto 0);
    signal instrucao,const:  unsigned(15 downto 0);
    signal estado:  unsigned(1 downto 0);
    signal PC:  unsigned(15 downto 0);
    signal wr_enBanco, wr_enAcumulador, MOV_R_A, MOV_A_R, soma_acumulador :  std_logic;

    signal   finished    : std_logic := '0';
    constant period_time  : time := 100 ns;

begin
    uut : UC port map(clk,rst,f_carry,f_zero,opcode_ULA,reg_selec,instrucao,const,estado,PC,wr_enBanco,wr_enAcumulador,MOV_R_A,MOV_A_R,soma_acumulador);

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