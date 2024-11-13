library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ULAeBanco_tb is
end ULAeBanco_tb;

architecture a_ULAeBanco_tb of ULAeBanco_tb is
    component ULAeBanco is
        port(
            wr_banco, wr_acumulador, clock, reset,load_acc : in std_logic;
            data_acc : in unsigned (15 downto 0);
            opcode : in unsigned (1 downto 0);
            reg_banco : in unsigned (3 downto 0);
            data_banco : in unsigned (15 downto 0);
            saida : out unsigned(15 downto 0);
            f_zero, f_carry : out std_logic
        );
    end component;

    signal wr_banco, wr_acumulador, clk, rst, load_acc : std_logic;
    signal data_acc :  unsigned (15 downto 0);
    signal opcode : unsigned (1 downto 0);
    signal reg_banco : unsigned (3 downto 0);
    signal data_banco : unsigned (15 downto 0);
    signal saida : unsigned(15 downto 0);
    signal f_zero, f_carry : std_logic;

    signal   finished    : std_logic := '0';
    constant period_time  : time := 100 ns;

begin
    uut : ULAeBanco port map(   wr_banco => wr_banco, 
                                wr_acumulador => wr_acumulador,
                                clock=> clk, 
                                reset=> rst, 
                                opcode=>opcode, 
                                reg_banco=>reg_banco, 
                                data_banco=>data_banco, 
                                saida=>saida, 
                                f_zero=>f_zero, 
                                f_carry=>f_carry,
                                load_acc=>load_acc,
                                data_acc=>data_acc);

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
        wr_banco<='1';
        wr_acumulador<='1';
        load_acc<='1';
        data_acc<="0000000000000011";
        data_banco<="0000000000000011";
        reg_banco<="0001";
        opcode<="00";
        wait for period_time*2;
        load_acc<='0';
        wr_banco<='0';
        wr_acumulador<='0';
        wait for period_time*2;
        data_banco<="0000000000000001";
        reg_banco<="0010";
        wait for period_time*2;
        wr_banco<='1';
        wait for period_time*2;
        wr_banco<='0';
        wait;
    end process;

end architecture;