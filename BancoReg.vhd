library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity BancoReg is 
    port (
        wr_en, clk, rst : in std_logic;
        reg_selec : in unsigned(3 downto 0);
        data_write : in   unsigned(15 downto 0);
        data_reg,saida : out unsigned(15 downto 0)
    );
end BancoReg;

architecture a_BancoReg of BancoReg is 
    component Reg16bits is
        port( clk, wr_en, rst : in std_logic;
              data_in  : in unsigned(15 downto 0);
              data_out : out unsigned(15 downto 0)
        );
     end component;

     signal data0,data1,data2,data3,data4,data5,data6,data7,data8,data9 : unsigned(15 downto 0);
     signal wr0,wr1,wr2,wr3,wr4,wr5,wr6,wr7,wr8,wr9:  std_logic;
begin
    R0 : Reg16bits 
    port map (  clk => clk,
                wr_en => wr0,
                rst => rst,
                data_in => data_write,
                data_out=> data0 );

    R1 : Reg16bits 
    port map (  clk => clk,
                wr_en => wr1,
                rst => rst,
                data_in => data_write,
                data_out=> data1 );

    R2 : Reg16bits 
    port map (  clk => clk,
                wr_en => wr2,
                rst => rst,
                data_in => data_write,
                data_out=> data2 );

    R3 : Reg16bits 
    port map (  clk => clk,
                wr_en => wr3,
                rst => rst,
                data_in => data_write,
                data_out=> data3 );

    R4 : Reg16bits 
    port map (  clk => clk,
                wr_en => wr4,
                rst => rst,
                data_in => data_write,
                data_out=> data4 );

    R5 : Reg16bits 
    port map (  clk => clk,
                wr_en => wr5,
                rst => rst,
                data_in => data_write,
                data_out=> data5 );

    R6 : Reg16bits 
    port map (  clk => clk,
                wr_en => wr6,
                rst => rst,
                data_in => data_write,
                data_out=> data6 );

    R7 : Reg16bits 
    port map (  clk => clk,
                wr_en => wr7,
                rst => rst,
                data_in => data_write,
                data_out=> data7 );

    R8 : Reg16bits 
    port map (  clk => clk,
                wr_en => wr8,
                rst => rst,
                data_in => data_write,
                data_out=> data8 );

    R9 : Reg16bits 
    port map (  clk => clk,
                wr_en => wr9,
                rst => rst,
                data_in => data_write,
                data_out=> data9 );

    wr0 <= '0';
    wr1 <= '1' when wr_en='1' and reg_selec="0001" else '0';
    wr2 <= '1' when wr_en='1' and reg_selec="0010" else '0';
    wr3 <= '1' when wr_en='1' and reg_selec="0011" else '0';
    wr4 <= '1' when wr_en='1' and reg_selec="0100" else '0';
    wr5 <= '1' when wr_en='1' and reg_selec="0101" else '0';
    wr6 <= '1' when wr_en='1' and reg_selec="0110" else '0';
    wr7 <= '1' when wr_en='1' and reg_selec="0111" else '0';
    wr8 <= '1' when wr_en='1' and reg_selec="1000" else '0';
    wr9 <= '1' when wr_en='1' and reg_selec="1001" else '0';

    data_reg <= data0 when reg_selec="0000" else
                data1 when reg_selec="0001" else
                data2 when reg_selec="0010" else
                data3 when reg_selec="0011" else
                data4 when reg_selec="0100" else
                data5 when reg_selec="0101" else
                data6 when reg_selec="0110" else
                data7 when reg_selec="0111" else
                data8 when reg_selec="1000" else
                data9 when reg_selec="1001" else
                "0000000000000000";
                
    saida <= data9;
end architecture;


