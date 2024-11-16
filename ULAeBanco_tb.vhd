library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ULAeBanco_tb is
end ULAeBanco_tb;

architecture a_ULAeBanco_tb of ULAeBanco_tb is
    component ULAeBanco is
        port(
            clk, rst, wr_enBanco, wr_enAcumulador : in std_logic;
            selec_op : in unsigned (1 downto 0);
            selec_reg : in unsigned (3 downto 0);
            data_in : in unsigned (15 downto 0);
            data_out : out unsigned (15 downto 0);
            f_carry, f_zero : out std_logic
        );
    end component;

    signal clk, rst, wr_enBanco, wr_enAcumulador : std_logic;
    signal selec_op : unsigned (1 downto 0);
    signal selec_reg : unsigned (3 downto 0);
    signal data_in : unsigned (15 downto 0);
    signal data_out : unsigned (15 downto 0);
    signal f_carry, f_zero : std_logic;

    signal   finished    : std_logic := '0';
    constant period_time  : time := 100 ns;

begin
    uut : ULAeBanco port map(clk,rst,wr_enBanco,wr_enAcumulador,selec_op,selec_reg,data_in,data_out,f_carry,f_zero);

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
        wait for period_time;

        -- habilita a escrita do banco e do acumulador
        wr_enBanco<='1';
        wr_enAcumulador<='1';
        -- seleciona adição
        selec_op<="00";
        -- escreve 1 o registrador 1
        selec_reg<="0001";
        data_in<="0000000000000001";
        -- A ula soma o registrador 1 com 0 do acumulador resultando em 1 que é escrito no acumulador
        wait for period_time;

        -- desativa a escrita do acumulador
        wr_enAcumulador<='0';
        -- escreve 2 no registrador 2
        selec_reg<="0010";
        data_in<="0000000000000010";
        -- A ula soma o registrador 2 com 1 do acumulador resultando em 3 
        wait for period_time;

        -- ativa o write do acumulador
        wr_enAcumulador<='1';
        wait for period_time;

        -- muda o registrador para zero
        selec_reg<="0000";
        -- escreve o 3 que estava na ula no acumulador e muda o saida do banco para 0. saida da ula ainda é 3
        wait for period_time;

        -- desativa a escrita do acumulador
        wr_enAcumulador<='0';
        -- escreve 3 no registrador 3
        selec_reg<="0011";
        data_in<="0000000000000011";
        -- a ula soma o registrador 3 com o 3 do acumulador resultando em uma saida 3
        wait;
    end process;

end architecture;