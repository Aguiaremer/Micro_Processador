library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Reg19bits is
   port( clk, wr_en, rst : in std_logic;
         data_in  : in unsigned(18 downto 0);
         data_out : out unsigned(18 downto 0)
   );
end Reg19bits;

architecture a_Reg19bits of Reg19bits is
    signal registro: unsigned(18 downto 0);

begin
    process(clk,rst,wr_en) 
    begin                
       if rst='1' then
          registro <= "0000000000000000000";
       elsif wr_en='1' then
          if rising_edge(clk) then
             registro <= data_in;
          end if;
       end if;
    end process;
    data_out <= registro;
 end architecture;
