----------------------------------------------------------------------------------
-- ALU (Arithmetic Logic Unit)
-- inputs: a & b (8 bits), cin (1 bit), opcode (4 bits) 
-- output: y (8 bits)
-- signals: y_unsig (logic), y_sig(Arithmetic) 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;   -- for a + b and a + b + cin (arithmetic operation on std_logic_vectors)
use IEEE.NUMERIC_STD.ALL;			-- Arithmetic operation


-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
GENERIC (N: INTEGER := 8);
PORT(
	a			: IN 	std_logic_vector(N-1 downto 0);
	b			: IN 	std_logic_vector(N-1 downto 0);
	cin		: IN 	std_logic;
	opcode	: IN 	std_logic_vector(3 downto 0);
	y			: OUT std_logic_vector(N-1 downto 0)
);
end ALU;

architecture Behavioral of ALU is
SIGNAL y_sig	:SIGNED(N-1 downto 0); --for Arithmetic op (when opcode <= '1')
SIGNAL y_unsig	:std_logic_vector(N-1 downto 0); -- for logic op (when opcode <= '0') 
begin

y <= 	y_unsig WHEN opcode(3) = '0' ELSE
		std_logic_vector(y_sig); -- what would this do??---

------ LOGIC UNIT ----- 
WITH opcode (2 downto 0) SELECT 
y_unsig <= 
			NOT 	a		WHEN "000",
			NOT 	b		WHEN "001",
		a 	AND 	b		WHEN "010",
		a 	OR 	b		WHEN "011",
		a 	NAND 	b		WHEN "100",
		a 	NOR	b		WHEN "101",
		a 	XOR	b		WHEN "110",
		a 	XNOR	b		WHEN OTHERS;
------ ARITHMETIC UNIT ----- 
WITH opcode (2 downto 0) SELECT
y_sig <= 
			SIGNED(a)				WHEN "000",
			SIGNED(b)				WHEN "001",
			SIGNED(a) + 1			WHEN "010",
			SIGNED(b) +	1			WHEN "011",
			SIGNED(a) -	1			WHEN "100",
			SIGNED(b) -	1			WHEN "101",
			SIGNED(a + b)			WHEN "110",
			SIGNED(a + b + cin)	WHEN OTHERS; -- iS it OK to do this type casting??---

end Behavioral;

