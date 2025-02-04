library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ULAeBanco is
    port(
        clk, rst, wr_enBanco, wr_enAcumulador, wr_enFlags, lw_flag: in std_logic;
        MOV_A_R, MOV_R_A, soma_acumulador : in std_logic;
        opcode_ULA : in unsigned (1 downto 0);
        reg_selec : in unsigned (3 downto 0);
        data_in, data_ram : in unsigned (15 downto 0);
        data_out : out unsigned (15 downto 0);
        reg_dado : out unsigned (6 downto 0);
        acumulador_s, banco_s: out unsigned (15 downto 0);
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

    component Reg1bits is
        port( 
            clk, wr_en, rst : in std_logic;
            data_in  : in std_logic;
            data_out : out std_logic
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

    signal banco_in, banco_out, acumulador_in, acumulador_out, ula_out, entrA_s : unsigned (15 downto 0);
    signal f_carry_s, f_zero_s : std_logic;



begin
    ULAeBanco_Banco : BancoReg
    port map (  clk => clk,
                rst => rst,
                wr_en => wr_enBanco,
                reg_selec => reg_selec,
                data_write => banco_in,
                data_reg => banco_out       );

    ULAeBanco_Acumulador : Reg16bits
    port map (  clk => clk,
                rst => rst,
                wr_en => wr_enAcumulador,
                data_in => acumulador_in,
                data_out => acumulador_out  );

    ULAeBanco_ULA : ULA 
    port map (  entrA => entrA_s,
                entrB => acumulador_out,
                resul => ula_out,
                selec => opcode_ULA,
                carry => f_carry_s,
                zero => f_zero_s             );

    ULAeBanco_ff_carry : Reg1bits
    port map (  clk => clk,
                rst => rst,
                wr_en => wr_enAcumulador,
                data_in => f_carry_s,
                data_out => f_carry  );
    
    ULAeBanco_ff_zero : Reg1bits
    port map (  clk => clk,
                rst => rst,
                wr_en => wr_enAcumulador,
                data_in => f_zero_s,
                data_out => f_zero  );
    
    

    banco_in <= acumulador_out when MOV_A_R='1' else data_in;

    acumulador_in<= banco_out when MOV_R_A='1' else data_ram when lw_flag='1' else ula_out;

    entrA_s <= data_in when soma_acumulador='1' else banco_out;
    
    data_out <= ula_out;

    acumulador_s<=acumulador_out;
    banco_s<=banco_out;
    reg_dado<=banco_out(6 downto 0);

end architecture;