library ieee; -- Ta errado precisa mudar
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ULA is
    port(
        entrA : in UNSIGNED(15 downto 0);
        entrB : in UNSIGNED(15 downto 0);
        selec : in UNSIGNED(1 downto 0);
        resul : out UNSIGNED(15 downto 0);
        carry, zero : out std_logic
    );
end ULA;

architecture a_ULA of ULA is
    component MUX is
        port (
            in_a, in_b, in_c, in_d : in UNSIGNED(16 downto 0);
            sel_mux : in UNSIGNED(1 downto 0);
            out_mux : out UNSIGNED(16 downto 0)
        );
    end component;

    signal sum_sinal, sub_sinal, or_sinal, and_sinal : UNSIGNED(16 downto 0);
    signal a_temp, b_temp, resul_aux : UNSIGNED(16 downto 0);

begin
    a_temp <= '0' & entrA;
    b_temp <= '0' & entrB;
    sum_sinal <= a_temp + b_temp;
    sub_sinal <= a_temp - b_temp;
    or_sinal <= a_temp or b_temp;
    and_sinal <= a_temp and b_temp;
    mux1 : MUX port map(sel_mux => selec, 
                        in_a => sum_sinal, 
                        in_b => sub_sinal, 
                        in_c => or_sinal, 
                        in_d => and_sinal, 
                        out_mux => resul_aux);
    carry <= resul_aux(16);
    zero <= '1' when resul_aux="00000000000000000" else '0';
    resul <= resul_aux(15 downto 0);
end architecture; 