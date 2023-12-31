---_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_---
-- COMPONENTE: CPU
-- DESCRIÇÃO: 
--     RESPONSÁVEL POR EXECUTAR O PROGRAMA ARMAZENADO NA
--     MEMÓRIA ROM, UTILIZANDO DOS OUTROS COMPONENTES
---_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_---

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY CPU_DYNASTY IS
    PORT(
        CLOCK            : IN STD_LOGIC;
        PC_OUT           : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        ROM_OUT          : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        OPCODE_OUT       : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        RS_OUT, RT_OUT   : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
        ADDRESS_OUT      : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        R_A_OUT, R_B_OUT : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        ALU_RESULT_OUT   : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        RAM_OUT          : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        MUX_2_OUT        : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE BEHAVIOR OF CPU_DYNASTY IS
    SIGNAL MEM_ROM                                 : STD_LOGIC_VECTOR(15 DOWNTO 0);
	 SIGNAL OUT_CONTADOR_PC, OUT_PC, ADDR           : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL OPC                                     : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL R1, R2                                  : STD_LOGIC_VECTOR(5 DOWNTO 0);
    SIGNAL FLAG_JUMP, FLAG_BRANCH                  : STD_LOGIC;
    SIGNAL FLAG_MEMREAD, FLAG_MEMTOREG             : STD_LOGIC;
    SIGNAL FLAG_ALUOP                             : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL FLAG_MEMWRITE, FLAG_ALUSRC              : STD_LOGIC;
    SIGNAL FLAG_REGWRITE                          : STD_LOGIC;
    SIGNAL R_A, R_B, MEM_RAM, ALU_OUT              : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL MUX1, MUX2, MUX3, MUX4                  : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL ALU_Z, ALU_OVERFLOW, AND_0             : STD_LOGIC;
    SIGNAL SOMADOR_MUX_3                          : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL CARRY_OUT_SOMADOR_MUX_3                : STD_LOGIC;
    SIGNAL SINAL_EXTENSOR_6X16, SINAL_EXTENSOR_4X16 : STD_LOGIC_VECTOR(15 DOWNTO 0);

    COMPONENT PC IS
        PORT (
            CLOCK       : IN STD_LOGIC;
            ADDRESS_IN  : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            ADDRESS_OUT : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT CONTADOR_SINCRONO IS
        PORT (
            CLOCK : IN STD_LOGIC;
            A     : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            S     : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT Divisor IS
        PORT (
        INSTRUCTION     : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        OPCODE 			: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		  ADDRESS 			: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        RS, RT          : OUT STD_LOGIC_VECTOR(5 DOWNTO 0)
		  );
    END COMPONENT;

    COMPONENT BANCO_REGISTRADORES IS
        PORT (
            CLOCK, REG_WRITE   : IN STD_LOGIC;
            REG1_IN, REG2_IN   : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
            WRITE_DATA         : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            REG1_OUT, REG2_OUT : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT EXTENSOR_6X16 IS
        PORT (
            A : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
            S : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT EXTENSOR_4X16 IS
        PORT (
            A : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            S : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT RAM IS
        PORT (
            CLOCK, MEM_WRITE, MEM_READ : IN STD_LOGIC;
            A, ADDRESS                 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            S                         : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT ROM IS
        PORT (
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
        PORT (
            CLOCK     : IN STD_LOGIC;
            OP        : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            A, B      : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            S         : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            Z         : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT UNIDADE_DE_CONTROLE IS
        PORT (
            CLOCK    : IN STD_LOGIC;
            OPCODE   : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            JUMP     : OUT STD_LOGIC;
            BRANCH   : OUT STD_LOGIC;
            MEMREAD  : OUT STD_LOGIC;
            MEMTOREG : OUT STD_LOGIC;
            ALUOP    : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            MEMWRITE : OUT STD_LOGIC;
            ALUSRC   : OUT STD_LOGIC;
            REGWRITE : OUT STD_LOGIC
        );
    END COMPONENT;

BEGIN
    COMP_CONTADOR_PC         : CONTADOR_SINCRONO PORT MAP(CLOCK, OUT_PC, OUT_CONTADOR_PC);
    COMP_PC                  : PC PORT MAP(CLOCK, MUX4, OUT_PC);
    COMP_ROM                 : ROM PORT MAP(CLOCK, OUT_PC, MEM_ROM);
    COMP_DIV_INSTRUCAO		  : Divisor PORT MAP(MEM_ROM, OPC, ADDR, R1, R2);
    COMP_UNIDADE_DE_CONTROLE : UNIDADE_DE_CONTROLE PORT MAP(CLOCK, OPC, FLAG_JUMP, FLAG_BRANCH, FLAG_MEMREAD, FLAG_MEMTOREG, FLAG_ALUOP, FLAG_MEMWRITE, FLAG_ALUSRC, FLAG_REGWRITE);
    COMP_BANCO_REGISTRADORES : BANCO_REGISTRADORES PORT MAP(CLOCK, FLAG_REGWRITE, R1, R2, MUX2, R_A, R_B);
	 COMP_EXTENSOR_6X16       : EXTENSOR_6X16 PORT MAP(R2, SINAL_EXTENSOR_6X16);
    COMP_MUX_1               : MUX_2X1 PORT MAP(FLAG_ALUSRC, R_B, SINAL_EXTENSOR_6X16, MUX1);
    COMP_ALU                 : ALU PORT MAP(CLOCK, FLAG_ALUOP, R_A, MUX1, ALU_OUT, ALU_Z);
    COMP_RAM                 : RAM PORT MAP(CLOCK, FLAG_MEMWRITE, FLAG_MEMREAD, ALU_OUT, SINAL_EXTENSOR_6X16, MEM_RAM);
    COMP_MUX_2               : MUX_2X1 PORT MAP(FLAG_MEMTOREG, ALU_OUT, MEM_RAM, MUX2);
    COMP_MUX_3               : MUX_2X1 PORT MAP(SELECTOR => AND_0, A => OUT_CONTADOR_PC, B => ADDR, RESULT => MUX3);
    COMP_MUX_4               : MUX_2X1 PORT MAP(SELECTOR => FLAG_JUMP, A => MUX3, B => ADDR, RESULT => MUX4);
	 
	 
    AND_0                   <= FLAG_BRANCH AND ALU_Z;
    PC_OUT                  <= OUT_PC;
    ROM_OUT                 <= MEM_ROM;
    OPCODE_OUT              <= OPC;
    RS_OUT                  <= R1;
    RT_OUT                  <= R2;
    ADDRESS_OUT             <= ADDR;
    R_A_OUT                 <= R_A;
    R_B_OUT                 <= R_B;
    ALU_RESULT_OUT          <= ALU_OUT;
    RAM_OUT                 <= MEM_RAM;
    MUX_2_OUT               <= MUX2;
END;