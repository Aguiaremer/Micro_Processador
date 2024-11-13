library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ULAeBanco is
    port(
        clk, rst, wr_enBanco, wr_enAcumulador : in std_logic;
        selec_op : in unsigned (1 downto 0);
        selec_reg : in unsigned (3 downto 0);
        data_in : in unsigned (15 downto 0);
        data_out : out unsigned (15 downto 0);
        f_carry, f_zero : out std_logic
    );
end ULAeBanco;

architecture a_ULAeBanco of ULAeBanco is
    component ULA is
        port(
            entrA, entrB : in UNSIGNED(15 downto 0);
            selec : in UNSIGNED(1 downto 0);
            resul : out UNSIGNED(15 downto 0);
            carry, zero : out std_logic
        );
    end component;

    component Reg16bits is
        port( clk, wr_en, rst : in std_logic;
            data_in  : in unsigned(15 downto 0);
            data_out : out unsigned(15 downto 0)
        );
    end component;

    component BancoReg is
        port (
        wr_en, clk, rst : in std_logic;
        reg_selec : in unsigned(3 downto 0);
        data_write : in   unsigned(15 downto 0);
        data_reg : out unsigned(15 downto 0)
        );
    end component;

    signal banco_out, acumulador_out, ula_out : unsigned (15 downto 0);


begin
    Banco : BancoReg
    port map (  clk => clk,
                rst => rst,
                wr_en => wr_enBanco,
                reg_selec => selec_reg,
                data_write => data_in,
                data_reg => banco_out       );

    acumulador : Reg16bits
    port map (  clk => clk,
                rst => rst,
                wr_en => wr_enAcumulador,
                data_in => ula_out,
                data_out => acumulador_out  );

    ULAt : ULA 
    port map (  entrA => banco_out,
                entrB => acumulador_out,
                resul => ula_out,
                selec => selec_op,
                carry => f_carry,
                zero => f_zero              );
    
    data_out <= ula_out;

end architecture;