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
	RESULT <= A when SELECTOR = '0' 
	else B;
END;
