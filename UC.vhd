library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity UC is
    port(
        clk, rst, f_carry, f_zero : in std_logic;
        opcode_ULA: out unsigned (1 downto 0);
        reg_selec: out unsigned (3 downto 0);
        instrucao, const: out unsigned(15 downto 0);
        estado: out unsigned(1 downto 0);
        PC: out unsigned(15 downto 0);
        wr_enBanco, wr_enAcumulador, wr_enRAM, wr_enFlags, MOV_R_A, MOV_A_R, lw_flag, soma_acumulador : out std_logic
    );
end entity;

architecture a_UC of UC is
    component Reg16bits is
        port( 
            clk, wr_en, rst : in std_logic;
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

    component MaqEst is
        port(
            clk, rst: in std_logic;
            estado: out unsigned(1 downto 0)
        );
    end component;
    
    signal wren_PC, wren_instr_reg : std_logic;
    signal PC_out, PC_in, instr_reg_in, instr_reg_out, const_s : unsigned(15 downto 0);
    signal MaqEst_out : unsigned(1 downto 0);
    signal endereco_ROM: unsigned(6 downto 0);
    signal const_temp : unsigned (7 downto 0);
    signal instrucao_temp: unsigned(18 downto 0);
    signal opcode : unsigned(3 downto 0);



begin

    UC_PC : Reg16bits
    port map(
        clk => clk,
        rst => rst,
        wr_en => wren_PC,
        data_in => PC_in,
        data_out => PC_out
    );

    UC_Instr_reg : Reg16bits
    port map(
        clk => clk,
        rst => rst,
        wr_en => wren_instr_reg,
        data_in => instr_reg_in,
        data_out => instr_reg_out
    );

    UC_ROM : ROM
    port map (
        clk => clk,
        endereco => endereco_rom,
        dado => instrucao_temp
    );

    UC_MaqEst : MaqEst
    port map (
        clk => clk,
        rst => rst,
        estado => MaqEst_out
    );

    ------------- fetch
    endereco_rom<=pc_out(6 downto 0);
    wren_instr_reg <= '1' when MaqEst_out="00" else '0';
    instr_reg_in <= instrucao_temp(18 downto 3);
    opcode <= instrucao_temp(18 downto 15);
 

    ------------- decode

    
    -- update pc
    wren_PC <=  '1' when MaqEst_out="01" else '0';
    PC_in  <=   "000000000" & instr_reg_out(11 downto 5) when opcode="0101" else 
                PC_out + const_s when opcode="0111" and f_carry='1' and f_zero='0' else
                PC_out + const_s when opcode="1000" and f_carry='1' else
                PC_out + 1;

    -- seleção de registrador
    reg_selec<= instr_reg_out(11 downto 8) when opcode="0001" or opcode="0010" or opcode="0011" or opcode="1010" or opcode="1011" or (opcode="0110" and instr_reg_out(7 downto 4)="1011") else 
                instr_reg_out(7 downto 4) when opcode="0110" and instr_reg_out(11 downto 8)="1011" else
                "0000";

    -- def constante
    const_temp<=instr_reg_out(11 downto 4) when opcode="1001" or opcode="0111" or opcode="1000" or opcode="0100" else
                instr_reg_out(7 downto 0) when opcode="0001" else 
                "00000000";

    -- extensão de sinal
    const_s <=  "00000000"&const_temp when const_temp(7)='0'else "11111111"&const_temp;

    -- define o opcode da Ula
    opcode_ULA<="00" when opcode="0010" or opcode="0100" else 
                "01" when opcode="1001" or opcode="0011" else
                "11";
    
    ------------- execute

    -- instrucao mov
    MOV_R_A<= '1' when MaqEst_out="10" and opcode="0110" and instr_reg_out(7 downto 4)="1011" else '0';
    MOV_A_R<= '1' when MaqEst_out="10" and opcode="0110" and instr_reg_out(11 downto 8)="1011" else '0';

    lw_flag <= '1' when MaqEst_out="10" and opcode="1010" else '0';

    soma_acumulador<= '1' when MaqEst_out="10" and (opcode="0100" or opcode="1001") else '0';

    wr_enBanco<= '1' when MaqEst_out="10" and (opcode="0001" or (opcode="0110" and instr_reg_out(11 downto 8)="1011")) else '0';

    wr_enRAM <= '1' when MaqEst_out="10" and opcode="1011" else '0';

    wr_enAcumulador <= '1' when MaqEst_out="10" and (opcode="0010" or opcode="0011" or opcode="0100" or opcode="1010" or (opcode="0110" and instr_reg_out(7 downto 4)="1011")) else '0';
    
    wr_enFlags <= '1' when MaqEst_out="10" and (opcode="0010" or opcode="0011" or opcode="0100" or opcode="1001") else '0';

    
    ----------

    const<=const_s;
    instrucao <= instr_reg_out;
    estado<=MaqEst_out;
    PC <= PC_out;

                


end architecture;