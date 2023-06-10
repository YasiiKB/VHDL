----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:48:35 05/14/2023 
-- Design Name: 
-- Module Name:    shift_register - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity shift_register is
	 GENERIC (N: INTEGER := 4);
    Port 	(din : in  STD_LOGIC;
				 clk  : in  STD_LOGIC;
				 rst  : in  STD_LOGIC;
				 dout : out  STD_LOGIC);
end shift_register;

architecture Behavioral of shift_register is

begin

PROCESS (clk, rst)
VARIABLE q: STD_LOGIC_VECTOR (N-1 downto 0);

BEGIN 
	IF (rst = '0') THEN
		q := (OTHERS => '0');
	ELSIF (clk' EVENT AND clk = '1') THEN
		q := din & q(N-1 downto 1); 
	END IF;
	dout <= q(0);
	
end PROCESS;
end Behavioral;

