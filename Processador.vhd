library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Processador is
    port(
        clk, rst : in std_logic;
        instrucao: out unsigned(15 downto 0);
        estado: out unsigned(1 downto 0);
        PC: out unsigned(15 downto 0);
        acumulador_out, banco_out: out unsigned (15 downto 0);
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
            wr_enBanco, wr_enAcumulador, wr_enFlags, MOV_R_A, MOV_A_R, soma_acumulador : out std_logic
        );
    end component;

    component ULAeBanco is
        port(
            clk, rst, wr_enBanco, wr_enAcumulador, wr_enFlags: in std_logic;
            MOV_A_R, MOV_R_A, soma_acumulador : in std_logic;
            opcode_ULA : in unsigned (1 downto 0);
            reg_selec : in unsigned (3 downto 0);
            data_in : in unsigned (15 downto 0);
            data_out : out unsigned (15 downto 0);
            acumulador_s, banco_s: out unsigned (15 downto 0);
            f_carry, f_zero : out std_logic
        );
    end component;

    signal wr_enBanco_s, wr_enAcumulador_s, wr_enFlags_s, MOV_R_A_s, MOV_A_R_s, soma_acumulador_s,carry,flag, f_carry_s, f_zero_s : std_logic;
    signal opcode_ULA_s : unsigned (1 downto 0);
    signal reg_selec_s: unsigned (3 downto 0);
    signal const_s : unsigned (15 downto 0);

begin
    
    Processador_UC : UC 
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
        const=>const_s,
        instrucao=>instrucao,
        estado=>estado,
        PC=>PC,
        f_carry=> f_carry_s,
        f_zero=> f_zero_s
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
        data_out=> ULA_out,
        acumulador_s=>acumulador_out,
        banco_s=>banco_out,
        f_carry=> f_carry_s,
        f_zero=> f_zero_s
    );





end architecture;