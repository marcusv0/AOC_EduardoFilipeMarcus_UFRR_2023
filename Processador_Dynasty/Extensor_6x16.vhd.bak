---_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_---
-- COMPONENTE: EXTENSOR_2X16
-- DESCRIÇÃO: 
--     EXTENDE UM SINAL DE 2 BITS PARA 1 BYTE
---_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_---

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY EXTENSOR_2X16 IS
    PORT(
        A : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        S : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
    );
END EXTENSOR_2X16;

ARCHITECTURE BEHAVIOR OF EXTENSOR_2X16 IS
BEGIN
    S(15 DOWNTO 2) <= (OTHERS => '0');
    S(1 DOWNTO 0) <= A;
END;
