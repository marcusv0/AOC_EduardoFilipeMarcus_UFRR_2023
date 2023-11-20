---_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_---
-- COMPONENTE: DIVISOR DE INSTRUÇÃO
-- DESCRIÇÃO: 
--     FORMATA O INPUT DAS INSTRUÇÕES PARA DIVIDIR OPCODE,
--     RS, RT E ENDEREÇO
---_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_---

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY DIV_INSTRUCAO_16BITS IS
    PORT(
        INSTRUCTION     : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        OPCODE, ADDRESS : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        RS, RT          : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END DIV_INSTRUCAO_16BITS;

ARCHITECTURE BEHAVIOR OF DIV_INSTRUCAO_16BITS IS
BEGIN
    OPCODE <= INSTRUCTION(15 DOWNTO 12);
    RS     <= INSTRUCTION(11 DOWNTO 8);
    RT     <= INSTRUCTION(7 DOWNTO 4);
    ADDRESS <= INSTRUCTION(3 DOWNTO 0);
END;
