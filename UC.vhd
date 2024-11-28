library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity UC is
    port(
        clk, rst : in std_logic;
        opcode_ULA: out unsigned (1 downto 0);
        reg_selec: out unsigned (3 downto 0);
        constante : out unsigned (7 downto 0);
        instrucao: out unsigned(15 downto 0);
        estado: out unsigned(1 downto 0);
        PC: out unsigned(15 downto 0);
        wr_enBanco, wr_enAcumulador, MOV_R_A, MOV_A_R, soma_acumulador : out std_logic
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
    signal PC_out, PC_in, instr_reg_in, instr_reg_out : unsigned(15 downto 0);
    signal MaqEst_out : unsigned(1 downto 0);
    signal endereco_ROM : unsigned(6 downto 0);
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
    PC_in  <=   "000000000" & instr_reg_out(11 downto 5) when opcode="0101" else PC_out + 1;    

    -- seleção de registrador
    reg_selec<= instr_reg_out(11 downto 8) when  MaqEst_out="01" and (opcode="0001" or opcode="0010" or opcode="0011" or (opcode="0110" and instr_reg_out(7 downto 4)="1011")) else
                instr_reg_out(7 downto 4) when MaqEst_out="01" and (opcode="0110" and instr_reg_out(11 downto 8)="1011");

    -- def constante
    constante<= instr_reg_out(7 downto 0) when MaqEst_out="01" and opcode="0001" else
                instr_reg_out(11 downto 4) when MaqEst_out="01" and opcode="0100";


    -- define o opcode da Ula
    opcode_ULA<="00" when opcode="0010" or opcode="0100" else
                "01" when opcode="0011";
    
    ------------- execute

    -- intrcuçao mov
    MOV_R_A<= '1' when MaqEst_out="10" and opcode="0110" and instr_reg_out(7 downto 4)="1011" else '0';
    MOV_A_R<= '1' when MaqEst_out="10" and opcode="0110" and instr_reg_out(11 downto 8)="1011" else '0';

    soma_acumulador<= '1' when MaqEst_out="10" and opcode="0100" else '0';

    wr_enBanco<= '1' when MaqEst_out="10" and (opcode="0001" or (opcode="0110" and instr_reg_out(11 downto 8)="1011")) else '0';

    wr_enAcumulador <= '1' when MaqEst_out="10" and (opcode="0010" or opcode="0011" or opcode="0100" or (opcode="0110" and instr_reg_out(7 downto 4)="1011")) else '0';
    
    ----------

    instrucao <= instr_reg_out;
    estado<=MaqEst_out;
    PC <= PC_out;

                


end architecture;