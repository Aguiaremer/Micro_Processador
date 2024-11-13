library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ULA_tb is
end ULA_tb;

architecture a_ULA_tb of ULA_tb is
    component ULA
        port(
            entrA : in UNSIGNED(15 downto 0);
            entrB : in UNSIGNED(15 downto 0);
            selec : in UNSIGNED(1 downto 0);
            resul : out UNSIGNED(15 downto 0);
            carry, zero : out std_logic
        );
    end component;

    signal entrA, entrB, resul :  UNSIGNED(15 downto 0);
    signal selec :  UNSIGNED(1 downto 0);
    signal carry, zero : std_logic;

begin
    uut : ULA port map( entrA,entrB,selec,resul,carry,zero);
    process
    begin
        --testando a soma
        selec<="00"; -- Selecionando operação de soma
        entrA<="0000000000001100"; -- 12
        entrB<="0000000000000111"; -- 7
        -- in: 12 + 7 out: 19(13 em hex) carry: 0 zero:0
        wait for 10 ns;
        

        selec<="00"; -- Selecionando operação de soma
        entrA<="0110101001100000"; --  27232
        entrB<="0001010110100001"; --  5537
        -- in: 27232 + 5537 out: 32769(8001 em hex) carry: 1 zero:0
        wait for 10 ns;

        selec<="00"; -- Selecionando operação de soma
        entrA<="0000000000010100"; --  20
        entrB<="1111111111110110"; -- -10
        -- in: 20 + -10 out: 10(A em hex) carry: 0 zero:0
        wait for 10 ns;

        selec<="00"; -- Selecionando operação de soma
        entrA<="0000000000001010"; --  10
        entrB<="1111111111101100"; -- -20
        -- in: 10 + -20 out: -10=65526(FFF6 em hex) carry: 0 zero:0
        wait for 10 ns;

        --testando a subtração
        selec<="01"; -- Selecionando operação de subtração
        entrA<="0000000000001100"; --  12
        entrB<="0000000000000111"; --  7
        -- in: 12 - 7 out: 5(5 em hex) carry: 0 zero:0
        wait for 10 ns;

        --testando a subtração
        selec<="01"; -- Selecionando operação de subtração
        entrA<="0000000000001000"; --  8
        entrB<="0000000000001010"; --  10
        -- in: 8 - 10 out: -2=65534(FFFE em hex) carry: 1 zero:0
        wait for 10 ns;

        selec<="01"; -- Selecionando operação de subtração
        entrA<="0000000000010100"; --  20
        entrB<="1111111111110110"; -- -10
        -- in: 20 - (-10) out: 30(1E em hex) carry: 0 zero:0
        wait for 10 ns;

        selec<="01"; -- Selecionando operação de subtração
        entrA<="1111111111101100"; -- -20
        entrB<="0000000000001010"; --  10
        -- in: -20 - 10 out: -30=65506(FFE2 em hex) carry: 0 zero:0
        wait for 10 ns;

        --testando o or
        selec<="10"; -- Selecionando operação de or
        entrA<="0000000000000000"; --  falso
        entrB<="0000000000000000"; --  falso
        -- in: 0 or 0 out: 0 carry: 0 zero: 1
        wait for 10 ns;

        selec<="10"; -- Selecionando operação de or
        entrA<="0000000000000001"; --  verdadeiro
        entrB<="0000000000000000"; --  falso
        -- in: 1 or 0 out: 1 carry: 0 zero: 0
        wait for 10 ns;

        selec<="10"; -- Selecionando operação de or
        entrA<="0000000000000000"; --  falso
        entrB<="0000000000000001"; --  verdadeiro
        -- in: 0 or 1 out: 1 carry: 0 zero: 0
        wait for 10 ns;

        selec<="10"; -- Selecionando operação de or
        entrA<="0000000000000001"; --  verdadeiro
        entrB<="0000000000000001"; --  verdadeiro
        -- in: 1 or 1 out: 1 carry: 0 zero: 0
        wait for 10 ns;

        --testando o and
        selec<="11"; -- Selecionando operação de and
        entrA<="0000000000000000"; --  falso
        entrB<="0000000000000000"; --  falso
        -- in: 0 and 0 out: 0 carry: 0 zero: 1
        wait for 10 ns;

        selec<="11"; -- Selecionando operação de and
        entrA<="0000000000000001"; --  verdadeiro
        entrB<="0000000000000000"; --  falso
        -- in: 1 and 0 out: 0 carry: 0 zero: 1
        wait for 10 ns;

        selec<="11"; -- Selecionando operação de and
        entrA<="0000000000000000"; --  falso
        entrB<="0000000000000001"; --  verdadeiro
        -- in: 0 and 1 out: 0 carry: 0 zero: 1
        wait for 10 ns;

        selec<="11"; -- Selecionando operação de and
        entrA<="0000000000000001"; --  verdadeiro
        entrB<="0000000000000001"; --  verdadeiro
        -- in: 1 and 1 out: 1 carry: 0 zero: 0
        wait for 10 ns;
        wait;
    end process;
end architecture;
        