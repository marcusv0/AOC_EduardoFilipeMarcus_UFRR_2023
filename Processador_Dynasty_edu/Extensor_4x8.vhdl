---_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_---
-- COMPONENTE: EXTENSOR_4X8
-- DESCRIÇÃO: 
--     EXTENDE UM SINAL DE 4 BITS PARA 1 BYTE
---_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_---

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY EXTENSOR_4X8 IS
    PORT(
        A : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        S : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
END EXTENSOR_4X8;

ARCHITECTURE BEHAVIOR OF EXTENSOR_4X8 IS
BEGIN
    S <= A;
END;
