---_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_---
-- COMPONENTE: CPU
-- DESCRIÇÃO: 
--     RESPONSÁVEL POR EXECUTAR O PROGRAMA ARMAZENADO NA
--     MEMÓRIA ROM, UTILIZANDO DOS OUTROS COMPONENTES
---_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_---

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY CPU_EK_16BITS IS
    PORT(
        CLOCK            : IN STD_LOGIC;
        PC_OUT           : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        ROM_OUT          : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        OPCODE_OUT       : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        RS_OUT, RT_OUT   : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        ADDRESS_OUT      : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        R_A_OUT,R_B_OUT  : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        ALU_RESULT_OUT   : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        ALU_OVERFLOW_OUT : OUT STD_LOGIC;
        RAM_OUT          : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        MUX_2_OUT        : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE BEHAVIOR OF CPU_EK_16BITS IS
    SIGNAL MEM_ROM, OUT_CONTADOR_PC, OUT_PC        : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL OPC, ADDR                              : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL R1, R2                                 : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL FLAG_JUMP, FLAG_BRANCH                 : STD_LOGIC;
    SIGNAL FLAG_MEMREAD, FLAG_MEMTOREG            : STD_LOGIC;
    SIGNAL FLAG_ALUOP                            : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL FLAG_MEMWRITE, FLAG_ALUSRC             : STD_LOGIC;
    SIGNAL FLAG_REGWRITE                         : STD_LOGIC;
    SIGNAL R_A, R_B, MEM_RAM, ALU_OUT             : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL MUX1, MUX2, MUX3, MUX4                 : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL ALU_Z, ALU_OVERFLOW, AND_0            : STD_LOGIC;
    SIGNAL SOMADOR_MUX_3                         : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL CARRY_OUT_SOMADOR_MUX_3               : STD_LOGIC;
    SIGNAL SINAL_EXTENSOR_2X8, SINAL_EXTENSOR_4X8 : STD_LOGIC_VECTOR(15 DOWNTO 0);

    COMPONENT PC IS
        PORT (
            CLOCK       : IN STD_LOGIC;
            ADDRESS_IN  : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            ADDRESS_OUT : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT CONTADOR_SINCRONO IS
        PORT(
            CLOCK : IN STD_LOGIC;
            A     : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            S     : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT DIV_INSTRUCAO IS
        PORT(
            INSTRUCTION     : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            OPCODE, ADDRESS : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            RS,RT           : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT BANCO_REGISTRADORES IS
        PORT(
            CLOCK, REG_WRITE   : IN STD_LOGIC;
            REG1_IN, REG2_IN   : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            WRITE_DATA         : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            REG1_OUT, REG2_OUT : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT EXTENSOR_2X8 IS
        PORT(
            A : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            S : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT EXTENSOR_4X8 IS
        PORT(
            A : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            S : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT RAM IS
        PORT(
            CLOCK, MEM_WRITE, MEM_READ : IN STD_LOGIC;
            A, ADDRESS                : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            S                        : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT ROM IS
        PORT(
            CLOCK : IN STD_LOGIC;
            A     : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            S     : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT MUX_2X1 IS
        PORT (
            SELECTOR : IN STD_LOGIC;
            A, B     : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            RESULT   : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT ALU IS
        PORT(
            CLOCK     : IN STD_LOGIC;
            OP        : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            A, B      : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            S         : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            Z, OVERFLOW : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT UNIDADE_DE_CONTROLE IS
        PORT(
            CLOCK    : IN STD_LOGIC;
            OPCODE   : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            JUMP     : OUT STD_LOGIC;
            BRANCH   : OUT STD_LOGIC;
            MEMREAD  : OUT STD_LOGIC
		  );
	 END COMPONENT;