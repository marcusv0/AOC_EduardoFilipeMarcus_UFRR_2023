---________________________________________________________---
-- COMPONENTE: CONTADOR SINCRONO
-- DESCRIÇÃO: 
--     REALIZA UMA CONTAGEM SÍNCRONA A PARTIR DOS CICLOS DE
--     CLOCK
---_____________________________________________________---

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY CONTADOR_SINCRONO IS
    PORT(
        CLOCK : IN STD_LOGIC;
        A     : IN STD_LOGIC_VECTOR(15 DOWNTO 0); 
        S     : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)  
    );
END CONTADOR_SINCRONO;

ARCHITECTURE BEHAVIOR OF CONTADOR_SINCRONO IS
BEGIN
    PROCESS(CLOCK, A)
    BEGIN
        IF RISING_EDGE(CLOCK) THEN
            S <= A + "0000000000000001"; 
        END IF;
    END PROCESS;
END BEHAVIOR;