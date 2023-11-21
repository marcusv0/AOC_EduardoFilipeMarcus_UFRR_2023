---_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_---
-- COMPONENTE: MUX_2X1
-- DESCRIÇÃO: 
--     SELECIONA UM ENTRE DOIS DADOS DE 1 BYTE
---_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_---

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY MUX_2X1 IS
    PORT (
        SELECTOR : IN STD_LOGIC;
        A,B      : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        RESULT   : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
    );
END MUX_2X1;

ARCHITECTURE BEHAVIOR OF MUX_2X1 IS
BEGIN
    PROCESS (SELECTOR, A, B)
    BEGIN
        CASE SELECTOR IS
            WHEN '0' => RESULT <= A;
            WHEN '1' => RESULT <= B;
            WHEN OTHERS => RESULT <= (OTHERS => '0'); -- Adicionado para caso o seletor não seja '0' ou '1'
        END CASE;
    END PROCESS;
END;
