library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ULA is
    port(
        entrA, entrB : in UNSIGNED(15 downto 0);
        selec : in UNSIGNED(1 downto 0);
        resul : out UNSIGNED(15 downto 0);
        carry, zero : out std_logic
    );
end ULA;

--00: adição
--01: subtração
--10: or
--11: and

architecture a_ULA of ULA is

    signal sum_signal, sub_signal, or_signal, and_signal, resul_temp : UNSIGNED(15 downto 0);

begin

    sum_signal <= entrA + entrB;
    sub_signal <= entrA - entrB;
    or_signal <= entrA or entrB;
    and_signal <= entrA and entrB;

    resul_temp<=sum_signal when selec="00" else
                sub_signal when selec="01" else
                or_signal when selec="10" else
                and_signal when selec="11" else
                "0000000000000000";
    
                -- carry só acontece quando as entradas são unsigned (positivos ou 0)
    carry<= sum_signal(15) when (selec="00"and entrA(15)='0' and entrB(15)='0') else
            sub_signal(15) when (selec="01"and entrA(15)='0' and entrB(15)='0') else
            '0';

    zero <= '1' when resul_temp="0000000000000000" else '0';

    resul <= resul_temp;

end architecture; 