----------------------------------------------------------------------------------
-- Encoder 8x3 
-- 	takes the number on the DIP switches and converts them to binary 
			--> input: DIP switched, output: SIGNAL encoder_out
-- Decoder 3x8 
-- 	takes the binary numbers and changes them to decimal 
--			--> input: SIGNAL encoder_out (encoder's output) , output: LEDs
-- REMINDER: DIP switches and LEDs are ACTIVE LOW
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity encoder_decoder is
port (
	DIP: in std_logic_vector(7 downto 0);
	LED: out std_logic_vector(7 downto 0)
);
end encoder_decoder;

architecture Behavioral of encoder_decoder is
SIGNAL encoder_out : std_logic_vector(2 downto 0);
SIGNAL address		 :	UNSIGNED (2 downto 0); -- for decoder
begin
------ Encoder 8x3 ---------- 
WITH DIP SELECT
	encoder_out	<= "000" when "11111110", -- active low (turns on with 0)
						"001" when "11111101",
						"010" when "11111011",
						"011" when "11110111",
						"100" when "11101111",
						"101" when "11011111",
						"110" when "10111111",
						"111" when OTHERS;
------ Decoder 3x8 ----------
address <= UNSIGNED(encoder_out); -- coverting vector to unsigned
gen : FOR i in DIP'range GENERATE
	LED(i) <= '1' WHEN i = address else '0';
end GENERATE;

end Behavioral;

