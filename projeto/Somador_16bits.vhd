---______________________________________________________---
-- COMPONENTE: SOMADOR_16BITS
-- DESCRIÇÃO: 
--     RESPONSÁVEL POR SOMAR DOIS NÚMEROS DE 16 BITS
---______________________________________________________---


LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY SOMADOR_16BITS IS
	PORT(
		A,B  : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		CIN  : IN STD_LOGIC;
		COUT : OUT STD_LOGIC;
		S    : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END ENTITY;

ARCHITECTURE BEHAVIOR OF SOMADOR_16BITS IS
BEGIN
	PROCESS(A, B, CIN)
	VARIABLE temp : UNSIGNED(16 DOWNTO 0);
	BEGIN
		temp := UNSIGNED('0' & A) + UNSIGNED('0' & B) + UNSIGNED((CIN & "0000000000000000"));
		S <= STD_LOGIC_VECTOR(temp(15 DOWNTO 0));
		COUT <= temp(16);
	END PROCESS;
END;