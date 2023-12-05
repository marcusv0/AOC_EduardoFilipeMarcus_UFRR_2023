---_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_---
-- COMPONENTE: EXTENSOR_4X16
-- DESCRIÇÃO: 
--     EXTENDE UM SINAL DE 4 BITS PARA 1 BYTE
---_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_---

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY EXTENSOR_4X16 IS
    PORT(
        A : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        S : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
    );
END EXTENSOR_4X16;

ARCHITECTURE BEHAVIOR OF EXTENSOR_4X16 IS
BEGIN
    S(15 DOWNTO 4) <= (OTHERS => '0');
    S(3 DOWNTO 0) <= A;
END;
