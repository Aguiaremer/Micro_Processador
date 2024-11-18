library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity UC is
    port(
        clk, rst : in std_logic;
        UC_out : out unsigned(18 downto 0)
    );
end entity;

architecture a_UC of UC is
    component Reg16bits is
        port( clk, wr_en, rst : in std_logic;
         data_in  : in unsigned(15 downto 0);
         data_out : out unsigned(15 downto 0)
        );
    end component;

    component ROM is
        port( 
        clk      : in std_logic;
        endereco : in unsigned(6 downto 0);
        dado     : out unsigned(18 downto 0) 
        );
    end component;

    signal pc_out, pc_in : unsigned(15 downto 0);
    signal endereco_rom : unsigned(6 downto 0);

begin

    PC : Reg16bits
    port map(
        clk => clk,
        rst => rst,
        wr_en => '1',
        data_in => pc_in,
        data_out => pc_out
    );

    UC_ROM : ROM
    port map (
        clk => clk,
        endereco => endereco_rom,
        dado => UC_out
    );

    process (clk,rst)
    begin
        if rst='1' then
            pc_in <= "0000000000000000";
        elsif rising_edge(clk) then
            pc_in <= pc_out + 1;
        end if;
    end process;

    endereco_rom <= pc_out(6 downto 0);

end architecture;