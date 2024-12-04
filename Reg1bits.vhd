library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Reg1bits is
   port( 
         clk, wr_en, rst : in std_logic;
         data_in  : in std_logic;
         data_out : out std_logic
   );
end Reg1bits;

architecture a_Reg1bits of Reg1bits is
    signal registro: std_logic;
begin
    process(clk,rst,wr_en) 
    begin                
       if rst='1' then
          registro <= '0';
       elsif wr_en='1' then
          if rising_edge(clk) then
             registro <= data_in;
          end if;
       end if;
    end process;
    data_out <= registro;
 end architecture;
