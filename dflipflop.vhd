----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:14:28 05/14/2023 
-- Design Name: 
-- Module Name:    dflipflop - Behavioral 
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

entity dflipflop is
    Port ( d : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           q : out  STD_LOGIC);
end dflipflop;

architecture Behavioral of dflipflop is

begin

PROCESS (clk)
BEGIN 
	IF (clk' EVENT AND clk ='1') THEN
		IF ( rst = '1') THEN
			q <= '0';
		ELSE
			q <= d;
		END IF;
	END IF;

END PROCESS;

end Behavioral;

