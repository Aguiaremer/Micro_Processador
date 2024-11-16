library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ROM is
   port( 
        clk      : in std_logic;
        endereco : in unsigned(6 downto 0);
        dado     : out unsigned(18 downto 0) 
   );
end entity;

architecture a_ROM of ROM is

   type mem is array (0 to 127) of unsigned(18 downto 0);
   constant conteudo_rom : mem := (

      0  => "0000000000000000001", --1
      1  => "0000000000000000001", --1
      2  => "0000000000000000010", --2
      3  => "0000000000000000011", --3
      4  => "0000000000000000101", --5
      5  => "0000000000000001000", --8
      6  => "0000000000000000000",
      7  => "0000000000000000000",
      8  => "0000000000000000000",
      9  => "0000000000000000000",

      others => (others=>'0')
   );

begin
   process(clk)
   begin
      if(rising_edge(clk)) then
         dado <= conteudo_rom(to_integer(endereco));
      end if;
   end process;
end architecture;

