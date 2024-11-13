library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ULAeBanco is
    port(
        wr_banco, wr_acumulador, clock, reset,load_acc : in std_logic;
        data_acc : in unsigned (15 downto 0);
        opcode : in unsigned (1 downto 0);
        reg_banco : in unsigned (3 downto 0);
        data_banco : in unsigned (15 downto 0);
        saida : out unsigned(15 downto 0);
        f_zero, f_carry : out std_logic
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

    signal saida_banco, saida_acumulador, saida_ULA,in_acc : unsigned(15 downto 0);
begin
    Banco : BancoReg
    port map (  clk => clock,
                wr_en => wr_banco,
                rst => reset,
                reg_selec => reg_banco,
                data_write => data_banco,
                data_reg => saida_banco        );

    acumulador : Reg16bits
    port map (  clk => clock,
                wr_en => wr_acumulador,
                rst => reset,
                data_in => in_acc,
                data_out => saida_acumulador    );

    ULAt : ULA 
    port map (  entrA => saida_banco,
                entrB => saida_acumulador,
                resul => saida_ULA,
                selec => opcode,
                carry => f_carry,
                zero => f_zero                  );

    in_acc <= data_acc when load_acc='1' else saida_ULA;
    saida <= saida_ULA;

end architecture;