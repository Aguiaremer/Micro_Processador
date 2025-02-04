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
      0  => B"0000000000000000_000", --NOP

      1  => B"0001_0001_00001011_000", --LD R1,11 
      2  => B"0110_0001_1011_0000_000", --MOV R1,A
      3  => B"0001_0010_00000001_000", --LD R2, 1
      4  => B"1011_0010_00000000_000", --SW R2 
      5  => B"0110_0000_1011_0000_000", --MOV R0,A 
      6  => B"1010_0010_00000000_000", --LW R2 
      
      7  => B"0001_0001_00000011_000", --LD R1,3 
      8  => B"0110_0001_1011_0000_000", --MOV R1,A
      9  => B"0001_0010_00000100_000", --LD R2, 4
      10 => B"1011_0010_00000000_000", --SW R2 
      11 => B"0110_0000_1011_0000_000", --MOV R0,A 
      12 => B"1010_0010_00000000_000", --LW R2 

      13 => B"0001_0001_00001001_000", --LD R1,9 
      14 => B"0110_0001_1011_0000_000", --MOV R1,A
      15 => B"0001_0010_00000000_000", --LD R2, 0
      16 => B"1011_0010_00000000_000", --SW R2 
      17 => B"0110_0000_1011_0000_000", --MOV R0,A 
      18 => B"1010_0010_00000000_000", --LW R2 

      19 => B"0001_0001_00000111_000", --LD R1,7 
      20 => B"0110_0001_1011_0000_000", --MOV R1,A
      21 => B"0001_0010_01111111_000", --LD R2, 127
      22 => B"1011_0010_00000000_000", --SW R2 
      23 => B"0110_0000_1011_0000_000", --MOV R0,A 
      24 => B"1010_0010_00000000_000", --LW R2 
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

