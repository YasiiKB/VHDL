----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:24:07 05/04/2023 
-- Design Name: 
-- Module Name:    address_decoder - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity address_decoder is
GENERIC ( N: INTEGER := 2);
PORT(
	address  :	IN std_logic_vector (N-1 downto 0);
	en			:	IN std_logic;
	wordline :	OUT std_logic_vector (2**N-1 downto 0)
);
end address_decoder;

architecture Behavioral of address_decoder is
signal addr_unsig : UNSIGNED (N-1 downto 0);
begin
addr_unsig <=  UNSIGNED (address);
gen: FOR i IN wordline' RANGE GENERATE
	wordline (i) <= '0' WHEN i = addr_unsig AND en = '1' ELSE '1';
end GENERATE; 
end Behavioral;

