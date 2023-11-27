---_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_---
-- COMPONENTE: PROGRAM COUNTER (PC)
-- DESCRIÇÃO: 
--     ARMAZENA O ENDEREÇO DA INSTRUÇÃO A SER LIDA NA
--     MEMÓRIA
---_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_---

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Program_Counter IS
    PORT (
        CLOCK       : IN STD_LOGIC;
        ADDRESS_IN  : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
        ADDRESS_OUT : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
    );
END Program_Counter;

ARCHITECTURE BEHAVIOR OF Program_Counter IS
BEGIN
    PROCESS(CLOCK)
    BEGIN
        IF RISING_EDGE(CLOCK) THEN
            ADDRESS_OUT <= ADDRESS_IN;
        END IF;
    END PROCESS;
END;
