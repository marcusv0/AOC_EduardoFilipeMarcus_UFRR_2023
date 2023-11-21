---_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_---
-- COMPONENTE: MEMÓRIA RAM
-- DESCRIÇÃO:
--     ARMAZENA 8 POSIÇÕES DE 16 BITS, PERMITINDO OPERAÇÕES
--     DE LEITURA E ESCRITA
---_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_---

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY RAM IS
    PORT(
        CLOCK, MEM_WRITE, MEM_READ : IN STD_LOGIC;
        A, ADDRESS                 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        S                         : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
    );
END RAM;

ARCHITECTURE BEHAVIOR OF RAM IS
    TYPE MEM_ARRAY IS ARRAY (0 TO 7) OF STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL MEM : MEM_ARRAY := (OTHERS => (OTHERS => '0'));
BEGIN
    PROCESS(CLOCK)
    BEGIN
        IF RISING_EDGE(CLOCK) THEN
            IF MEM_WRITE = '1' THEN
                MEM(TO_INTEGER(UNSIGNED(ADDRESS))) <= A;
            END IF;
            IF MEM_READ = '1' THEN
                S <= MEM(TO_INTEGER(UNSIGNED(ADDRESS)));
            END IF;
        END IF;
    END PROCESS;
END;
