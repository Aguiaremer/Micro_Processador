library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Processador is
    port(
        clk, rst : in std_logic;
        instrucao: out unsigned(15 downto 0);
        estado: out unsigned(1 downto 0);
        PC: out unsigned(15 downto 0);
        banco_out: out unsigned (15 downto 0);
        ULA_out : out unsigned(15 downto 0)
    );
end entity;

architecture a_Prcessador of Processador is 
    component UC is
        port(
            clk, rst, f_carry, f_zero : in std_logic;
            opcode_ULA: out unsigned (1 downto 0);
            reg_selec: out unsigned (3 downto 0);
            instrucao, const: out unsigned(15 downto 0);
            estado: out unsigned(1 downto 0);
            PC: out unsigned(15 downto 0);
            wr_enBanco, wr_enAcumulador, wr_enRAM, wr_enFlags, MOV_R_A, MOV_A_R, lw_flag, soma_acumulador : out std_logic
        );
    end component;

    component ULAeBanco is
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
    end component;

    component RAM is
        port(
            clk      : in std_logic;
            endereco : in unsigned(6 downto 0);
            wr_en    : in std_logic;
            dado_in  : in unsigned(15 downto 0);
            dado_out : out unsigned(15 downto 0) 
        );
    end component;


    signal wr_enBanco_s, wr_enAcumulador_s, wr_enRAM_s, wr_enFlags_s, MOV_R_A_s, MOV_A_R_s, lw_flag_s, soma_acumulador_s,carry,flag, f_carry_s, f_zero_s : std_logic;
    signal opcode_ULA_s : unsigned (1 downto 0);
    signal reg_selec_s: unsigned (3 downto 0);
    signal const_s, RAM_out, acumulador_out : unsigned (15 downto 0);
    signal endereco_RAM : unsigned(6 downto 0);

begin
    
    Processador_UC : UC 
    port map (
        clk=>clk,
        rst=>rst,
        wr_enBanco=> wr_enBanco_s,
        wr_enAcumulador=> wr_enAcumulador_s,
        wr_enFlags=>wr_enFlags_s,
        wr_enRAM=>wr_enRAM_s,
        MOV_R_A=> MOV_R_A_s,
        MOV_A_R=> MOV_A_R_s,
        soma_acumulador=> soma_acumulador_s,
        opcode_ULA=> opcode_ULA_s,
        reg_selec=>reg_selec_s,
        const=>const_s,
        instrucao=>instrucao,
        estado=>estado,
        PC=>PC,
        f_carry=> f_carry_s,
        f_zero=> f_zero_s,
        lw_flag=>lw_flag_s
    );

    Processador_ULAeBanco : ULAeBanco
    port map (
        clk=>clk,
        rst=>rst,
        wr_enBanco=> wr_enBanco_s,
        wr_enAcumulador=> wr_enAcumulador_s,
        wr_enFlags=>wr_enFlags_s,
        MOV_R_A=> MOV_R_A_s,
        MOV_A_R=> MOV_A_R_s,
        soma_acumulador=> soma_acumulador_s,
        opcode_ULA=> opcode_ULA_s,
        reg_selec=>reg_selec_s,
        data_in=> const_s,
        data_ram=>RAM_out,
        data_out=> ULA_out,
        reg_dado=> endereco_RAM,
        acumulador_s=>acumulador_out,
        banco_s=>banco_out,
        f_carry=> f_carry_s,
        f_zero=> f_zero_s,
        lw_flag=>lw_flag_s
    );

    Processador_RAM : RAM
    port map(
        clk => clk,
        endereco => endereco_RAM,
        wr_en => wr_enRAM_s,
        dado_in => acumulador_out,
        dado_out => RAM_out
    );








end architecture;