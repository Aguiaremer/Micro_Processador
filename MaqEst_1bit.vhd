library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MaqEst_1bit is
    port(
        clk, rst : in std_logic;
        estado : out std_logic
    );
end entity;

architecture a_MaqEst_1bit of MaqEst_1bit is
    signal estado_temp : std_logic;
begin
    process(clk,rst)
    begin
        if rst='1' then
            estado_temp <= '0';
        elsif rising_edge(clk) then
            estado_temp <= not estado_temp;
        end if;
    end process;
    estado <= estado_temp;
end architecture;