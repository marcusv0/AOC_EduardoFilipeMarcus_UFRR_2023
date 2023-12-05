---_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_---
-- COMPONENTE: EXTENSOR_6X16
-- DESCRIÇÃO: 
--     EXTENDE UM SINAL 
---_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_---

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY EXTENSOR_6X16 IS
    PORT(
        A : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
        S : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
    );
END EXTENSOR_6X16;

ARCHITECTURE BEHAVIOR OF EXTENSOR_6X16 IS
BEGIN
    S(15 DOWNTO 6) <= (OTHERS => '0');
    S(5 DOWNTO 0) <= A;
END;
