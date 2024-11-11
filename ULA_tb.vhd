library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ULA_tb is
    --vazio
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
        entrA<="0000000000001100"; --  12
        entrB<="0000000000000111"; --  7
        wait for 10 ns;

        selec<="00"; -- Selecionando operação de soma
        entrA<="0110101001100000"; --  27232
        entrB<="0001010110100001"; --  5537
        wait for 10 ns;

        selec<="00"; -- Selecionando operação de soma
        entrA<="0000000000010100"; --  20
        entrB<="1111111111110110"; -- -10
        wait for 10 ns;

        selec<="00"; -- Selecionando operação de soma
        entrA<="0000000000001010"; --  10
        entrB<="1111111111101100"; -- -20
        wait for 10 ns;

        --testando a subtração
        selec<="01"; -- Selecionando operação de subtração
        entrA<="0000000000001100"; --  12
        entrB<="0000000000000111"; --  7
        wait for 10 ns;

        selec<="01"; -- Selecionando operação de subtração
        entrA<="0000000000010100"; --  20
        entrB<="1111111111110110"; -- -10
        wait for 10 ns;

        selec<="01"; -- Selecionando operação de subtração
        entrA<="0000000000001010"; --  10
        entrB<="1111111111101100"; -- -20
        wait for 10 ns;

        --testando o or
        selec<="10"; -- Selecionando operação de or
        entrA<="0000000000000000"; --  falso
        entrB<="0000000000000000"; --  falso
        wait for 10 ns;

        selec<="10"; -- Selecionando operação de or
        entrA<="0000000000000001"; --  verdadeiro
        entrB<="0000000000000000"; --  falso
        wait for 10 ns;

        selec<="10"; -- Selecionando operação de or
        entrA<="0000000000000000"; --  falso
        entrB<="0000000000000001"; --  verdadeiro
        wait for 10 ns;

        selec<="10"; -- Selecionando operação de or
        entrA<="0000000000000001"; --  verdadeiro
        entrB<="0000000000000001"; --  verdadeiro
        wait for 10 ns;

        --testando o and
        selec<="11"; -- Selecionando operação de and
        entrA<="0000000000000000"; --  falso
        entrB<="0000000000000000"; --  falso
        wait for 10 ns;

        selec<="11"; -- Selecionando operação de and
        entrA<="0000000000000001"; --  verdadeiro
        entrB<="0000000000000000"; --  falso
        wait for 10 ns;

        selec<="11"; -- Selecionando operação de and
        entrA<="0000000000000000"; --  falso
        entrB<="0000000000000001"; --  verdadeiro
        wait for 10 ns;

        selec<="11"; -- Selecionando operação de and
        entrA<="0000000000000001"; --  verdadeiro
        entrB<="0000000000000001"; --  verdadeiro
        wait for 10 ns;
        wait;
    end process;
end architecture;
        