library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ULAeBanco_tb is
end ULAeBanco_tb;

architecture a_ULAeBanco_tb of ULAeBanco_tb is
    component ULAeBanco is
        port(
            clk, rst, wr_enBanco, wr_enAcumulador: in std_logic;
            MOV_A_R, MOV_R_A, soma_acumulador : in std_logic;
            opcode_ULA : in unsigned (1 downto 0);
            reg_selec : in unsigned (3 downto 0);
            data_in : in unsigned (15 downto 0);
            data_out : out unsigned (15 downto 0);
            acumulador_s, banco_s: out unsigned (15 downto 0);
            f_carry, f_zero : out std_logic
        );
    end component;

    signal clk, rst, wr_enBanco, wr_enAcumulador:  std_logic;
    signal MOV_A_R, MOV_R_A, soma_acumulador :  std_logic;
    signal opcode_ULA :  unsigned (1 downto 0);
    signal reg_selec :  unsigned (3 downto 0);
    signal data_in :  unsigned (15 downto 0);
    signal data_out :  unsigned (15 downto 0);
    signal acumulador_s, banco_s:  unsigned (15 downto 0);
    signal f_carry, f_zero :  std_logic;

    signal   finished    : std_logic := '0';
    constant period_time  : time := 100 ns;

begin
    uut : ULAeBanco port map(clk,rst,wr_enBanco,wr_enAcumulador,MOV_A_R,MOV_R_A,soma_acumulador,opcode_ULA,reg_selec,data_in,data_out,acumulador_s,banco_s,f_carry,f_zero);

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
        -- habilita a escrita do banco e do acumulador
        wr_enBanco<='1';
        wr_enAcumulador<='1';
        -- seleciona adição
        opcode_ULA<="00";
        -- escreve 1 o registrador 1
        reg_selec<="0001";
        data_in<="0000000000000001";
        -- A ula soma o registrador 1 com 0 do acumulador resultando em 1 que é escrito no acumulador
        wait for period_time*2;
        wr_enAcumulador<='0';
        wait for period_time;
        data_in<="0000000000000010";
        wait for period_time;
        MOV_A_R<='1';
        wait for period_time;
        MOV_A_R<='0';
        wait for period_time;
        data_in<="0000000000000011";
        wait;
    end process;

end architecture;