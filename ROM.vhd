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
      1  => B"0001_1001_00011110_000", --LD R9,30 
      2  => B"0001_0011_00000000_000", -- LD R3,0 
      3  => B"0001_0100_00000000_000", -- LD R4,0  
      4  => B"0110_0000_1011_0000_000", -- MOV R0,A
      5  => B"0010_0011_00000000_000", -- ADD R3
      6  => B"0010_0100_00000000_000", -- ADD R4
      7  => B"0110_1011_0100_0000_000", -- MOV A,R4
      8  => B"0110_0011_1011_0000_000", -- MOV R3,A
      9  => B"0100_00000001_0000_000", -- ADDI 1 
      10 => B"0110_1011_0011_0000_000", -- MOV A,R3
      12 => B"0110_1001_1011_0000_000", -- M0V R9,A
      13 => B"0011_0011_00000000_000", -- SUB R3
      14 => B"1001_00000000_0000_000", -- CMPI 0    
      15 => B"0111_11110101_0000_000", -- BHI -11
      16 => B"0110_0100_1011_0000_000", -- MOV R4,A 
      17 => B"0110_1011_0101_0000_000", -- MOV A,R5
      18 => B"0000000000000000_000", --NOP


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

