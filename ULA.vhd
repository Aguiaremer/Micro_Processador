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
--11: NOP

architecture a_ULA of ULA is

    signal or_signal, and_signal, resul_temp : UNSIGNED(15 downto 0);
    signal sum_signal, sub_signal, entrA_temp, entrB_temp : unsigned(16 downto 0);

begin

    entrA_temp<= '0' & entrA;
    entrB_temp<= '0' & entrB;

    sum_signal <= entrA_temp + entrB_temp;
    sub_signal <= entrA_temp - entrB_temp;
    or_signal <= entrA or entrB;
    and_signal <= entrA and entrB;

    resul_temp<=sum_signal (15 downto 0)    when selec="00" else
                sub_signal (15 downto 0)    when selec="01" else
                or_signal                   when selec="10" else
                "0000000000000000";
    
    --carry <= '1' when (selec = "00" and sum_signal(16) = '1') or (selec = "01" and entrA < entrB) else '0';

    
    carry<='1' when (selec = "00" and entrA(15) = '0' and entrB(15) = '0' and sum_signal(16) = '1') or -- Carry na adição: ocorre apenas se os números forem positivos e houver overflow 
                    (selec = "01" and entrA(15) = '0' and entrB(15) = '0' and entrA < entrB) -- Carry na subtração só ocorre se entrA < entrB e ambos forem positivos
                    else '0';

    zero <= '1' when resul_temp="0000000000000000" else '0';

    resul <= resul_temp;

end architecture; 