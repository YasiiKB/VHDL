----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:58:22 05/19/2023 
-- Design Name: 
-- Module Name:    timed_machine - Behavioral 
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

entity timed_machine is
    Port ( clk  : in  STD_LOGIC;
           rst  : in  STD_LOGIC;
           x 	 : in  STD_LOGIC;
           y    : out  STD_LOGIC); -- output is optional, not used
end timed_machine;

architecture Behavioral of timed_machine is

CONSTANT T1: INTEGER := 3;
CONSTANT T2: INTEGER := 4; -- has to be bigget than T1

TYPE state IS (A, B, C);
SIGNAL pr_state, nx_state: state; 
SIGNAL timer: NATURAL RANGE 0 to T2;

begin
------- Upper Section -------
PROCESS (clk, rst) 
VARIABLE count: NATURAL RANGE 0 to T2;
BEGIN
	IF (rst ='1') THEN
		pr_state <= A;
		count := 0;
	ELSIF (clk' EVENT AND clk ='1') THEN 
		count := count + 1; 
		IF (count >= timer) THEN  -- >= , not = (has to reach the timer)
			pr_state <= nx_state;
			count := 0; 
		END IF;
	END IF;
END PROCESS;
------- Lower Section -------
PROCESS (pr_state, x)  -- inputs of the combinational block
BEGIN 
	CASE pr_state IS
		WHEN A => 
			y <= '0';
			timer <= 1;  -- depends on the boards frequency, 1 isn't 1 sec really. 
			IF (x = '1') THEN
				nx_state <= B;
--			ELSE
--				timer <= T2;
--				nx_state <= A;
			END IF;
		WHEN B => 
			y <= '0';
			IF (x = '0') THEN
				timer <= T1; 
				nx_state <= C;
			ELSE 
				timer <= T2; 
				nx_state <= A;
			END IF;
		WHEN C => 
			y <= '1';
			timer <= T2;
			nx_state <= A;
			
	END CASE;
END PROCESS;
end Behavioral;

