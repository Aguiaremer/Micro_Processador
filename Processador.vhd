library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Processador is
    port(
        clk, rst : in std_logic
    );
end entity;

architecture a_Prcessador of Processador is 
    component UC is
        port(
            clk, rst : in std_logic
        );
    end component;


begin
    

end architecture;