---______________________________________________________---
-- COMPONENTE: ALU
-- DESCRIÇÃO: 
--     RESPONSÁVEL POR EXECUTAR AS INSTRUÇÕES:
--		  ------------------------
--    | CODIGO | NOME | TIPO |
--    |--------|------|------|
--    | 0000   | ADD	 |  R   |
-- 	| 0001   | ADDI |  I   |
-- 	| 0010   | SUB	 |  R   |
-- 	| 0011   | SUBI |  I   |
-- 	| 0100   | LW	 |  I   |
-- 	| 0101   | SW	 |  I   |
-- 	| 0110   | LI	 |  I   |
-- 	| 0111   | BEQ	 |  J   |
-- 	| 1000   | IF	 |  J   |
-- 	| 1001   | J	 |  J   |
---______________________________________________________---

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.std_logic_unsigned.ALL; --ATENCAO


ENTITY ALU IS
	PORT(
		CLOCK	   : IN STD_LOGIC;
		OP 	   : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		A,B	   : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		S        : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		Z        : OUT STD_LOGIC
	);
END ENTITY;
	
ARCHITECTURE BEHAVIOR OF ALU IS
SIGNAL IN_BRANCH_HELPER,OUT_BRANCH_HELPER : STD_LOGIC;


COMPONENT BRANCH_HELPER IS
	PORT (
	  A : IN STD_LOGIC;
	  S : OUT STD_LOGIC
	);
END COMPONENT; 

BEGIN
	BH  : BRANCH_HELPER PORT MAP(IN_BRANCH_HELPER, OUT_BRANCH_HELPER);
	
	PROCESS(CLOCK,OP,A,B,IN_BRANCH_HELPER,OUT_BRANCH_HELPER)
	BEGIN
		CASE OP IS
			-- SOMA
			WHEN "0000" =>
				S        <= A + B;
				
			-- SOMA IMEDIATA
			WHEN "0001" =>
				S        <= A+B;
				
			-- SUBTRAÇÃO
			WHEN "0010" =>
				S        <= A - B;
				
			-- SUBTRAÇÃO IMEDIATA
			WHEN "0011" =>
				S        <= A - B;
				
			-- LW
			WHEN "0100" =>
				S        <= A;
				
			-- SW
			WHEN "0101" =>
				S        <= A;
				
			-- LI
			WHEN "0110" =>
				S        <= B;
				
			-- BEQ
			WHEN "0111" =>
				IF OUT_BRANCH_HELPER = '1' THEN
					Z     <= '1';
				ELSE
					Z     <= '0';
				END IF;
				S        <= "0000000000000000";
				
			-- IF
			WHEN "1000" =>
				IF A = B THEN
					IN_BRANCH_HELPER <= '1';
				ELSE
					IN_BRANCH_HELPER <= '0';
				END IF;
				S <= "0000000000000000";
			-- J
			WHEN OTHERS =>
				S        <= "0000000000000000";
		END CASE;
	END PROCESS;
END;