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

      1  => B"0001_0001_00100000_000", --LD R1, 32

      2  => B"0110_0001_1011_0000_000", --MOV R1, A     <- loop 1
      3  => B"1011_0001_00000000_000", --SW R1

      4  => B"0100_11111111_0000_000", --ADDI -1
      5  => B"0110_1011_0001_0000_000", --MOV A, R1
      6  => B"1001_00000000_0000_000", --CPMI 0     
      7  => B"1000_11111011_0000_000", --BHS -5

      8  => B"0001_0001_00100000_000", --LD R1, 32
      9  => B"0001_0010_00000010_000", --LD R2, 2

      10 => B"0110_0010_1011_0000_000", --MOV R2, A 

      11 => B"0010_0010_00000000_000", --ADD R2          <- loop 2
      12 => B"0110_1011_0011_0000_000", --MOV A, R3
      13 => B"0110_0000_1011_0000_000", --MOV R0, A
      14 => B"1011_0011_00000000_000", --SW R3

      15 => B"0110_0011_1011_0000_000", --MOV R3, A
      16 => B"0011_0001_00000000_000", --SUB R1
      17 => B"1001_00000000_0000_000", --CPMI 0
      18 => B"0110_0011_1011_0000_000", --MOV R3, A
      19 => B"1000_11111000_0000_000", --BHS -8 



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

