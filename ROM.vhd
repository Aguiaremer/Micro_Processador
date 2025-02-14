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

-- 32 : 

architecture a_ROM of ROM is

   type mem is array (0 to 127) of unsigned(18 downto 0);
   constant conteudo_rom : mem := (
      0  => B"0000000000000000_000", --NOP

      1  => B"0110_0000_1011_0000_000", --MOV R0, A
      2  => B"0100_010000001101_000", --ADDI 127
      3  => B"0110_1011_0001_0000_000", --MOV A, R1

      4  => B"0110_0001_1011_0000_000", --MOV R1, A     <- loop 1
      5  => B"1011_0001_00000000_000", --SW R1

      6  => B"0100_111111111111_000", --ADDI -1
      7  => B"0110_1011_0001_0000_000", --MOV A, R1
      8  => B"1001_000000000000_000", --CPMI 0     
      9  => B"1000_11111011_0000_000", --BHS -5

      10 => B"0110_0000_1011_0000_000", --MOV R0, A
      11 => B"0100_010000001101_000", --ADDI 127
      12 => B"0110_1011_0001_0000_000", --MOV A, R1
      13 => B"0001_0010_00000010_000", --LD R2, 2

      14 => B"0110_0010_1011_0000_000", --MOV R2, A     <- loop 4

      15 => B"0010_0010_00000000_000", --ADD R2          <- loop 2
      16 => B"0110_1011_0011_0000_000", --MOV A, R3
      17 => B"0110_0000_1011_0000_000", --MOV R0, A
      18 => B"1011_0011_00000000_000", --SW R3

      19 => B"0110_0011_1011_0000_000", --MOV R3, A
      20 => B"0011_0001_00000000_000", --SUB R1
      21 => B"1001_000000000000_000", --CPMI 0
      22 => B"0110_0011_1011_0000_000", --MOV R3, A
      23 => B"0111_11111000_0000_000", --BHI -8 

      24 => B"0110_0010_1011_0000_000", --MOV R2, A  <- loop 3
      25 => B"1001_010000001101_000", --CPMI 127
      26 => B"1000_00001100_0000_000", --BHS 12

      27 => B"0110_0010_1011_0000_000", --MOV R2, A 
      28 => B"0100_000000000001_000", --ADDI 1
      29 => B"0110_1011_0010_0000_000", --MOV A, R2
      30 => B"1010_0010_00000000_000", --LW R2
      31 => B"0011_0010_00000000_000", --SUB R2
      32 => B"1001_000000000000_000", --CPMI 0
      33 => B"1000_11110111_0000_000", --BHS -9

      34 => B"0110_0010_1011_0000_000", --MOV R2, A
      35 => B"0011_0001_00000000_000", --SUB R1
      36 => B"1001_000000000000_000", --CPMI 0
      37 => B"0111_11101001_0000_000", --BHS -23

      38 => B"0001_0100_00000001_000", --LD R4, 1 

      39 => B"0110_0100_1011_0000_000", --MOV R4, A <-loop 5
      40 => B"0100_000000000001_000", --ADD 1
      41 => B"0110_1011_0100_0000_000", --MOV A, R4
      42 => B"1010_0100_00000000_000", --LW R4
      43 => B"0011_0100_00000000_000", --SUB R4
      44 => B"1001_000000000000_000", --CPMI 0
      45 => B"0111_11111010_0000_000", --BHI -6
      46 => B"0110_0100_1011_0000_000", --MOV R4, A
      47 => B"0110_1011_1001_0000_000", --MOV A, R9
      48 => B"0011_0001_00000000_000", --SUB R1
      49 => B"1001_000000000000_000", --CPMI 0
      50 => B"0111_11110101_0000_000", --BHS -11



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

