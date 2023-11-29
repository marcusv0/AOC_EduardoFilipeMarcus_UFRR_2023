LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY EXTENSOR_8X16 IS
    PORT (
        A : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        S : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
    );
END EXTENSOR_8X16;

ARCHITECTURE BEHAVIOR OF EXTENSOR_8X16 IS
BEGIN
    S(15 DOWNTO 8) <= (OTHERS => '0');
    S(7 DOWNTO 0) <= A;
END BEHAVIOR;