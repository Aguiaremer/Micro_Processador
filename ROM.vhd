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
      1  => B"0001_0011_00000101_000", --LD R3,5 
      2  => B"0001_0100_00001000_000", --LD R4,8 
      3  => B"0110_0000_1011_0000_000", --MOV R0,A
      4  => B"0010_0100_00000000_000", --ADD R4
      5  => B"0010_0011_00000000_000", --ADD R3
      6  => B"0110_1011_0101_0000_000", --MOV A,R5
      7  => B"0110_0101_1011_0000_000", --MOV R5,A 
      8  => B"0100_11111111_0000_000", --ADDI -1,
      9  => B"0110_1011_0101_0000_000", --MOV A,R5
      10 => B"0101_0010100_00000_000", --JMP 20
      12 => B"0110_0000_1011_0000_000", --MOV R0,A
      13 => B"0110_1011_0101_0000_000", --MOV A,R5
      14 => B"0000000000000000_000", --NOP

      19 => B"0000000000000000_000", --NOP
      20 =>B"0110_0101_1011_0000_000", --MOV R5,A
      21 =>B"0110_1011_0011_0000_000", --MOV A,R3 
      22 =>B"0101_0000011_00000_000", --JMP 3
      23 =>B"0110_0000_1011_0000_000",-- MOV R0,A
      24 =>B"0110_1011_0011_0000_000",-- MOV A,R3
      25 =>B"0000000000000000_000", -- NOP

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

