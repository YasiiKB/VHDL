----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:25:25 05/30/2023 
-- Design Name: 
-- Module Name:    car_alarm_flag - Behavioral 
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
--use IEEE.NUMERIC_STD.ALL;

entity car_alarm_flag is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           remote : in  STD_LOGIC;
           sensor : in  STD_LOGIC;
           alarm : out  STD_LOGIC);
end car_alarm_flag;

architecture Behavioral of car_alarm_flag is
TYPE state is (open_door, locked, theft);
SIGNAL pre_state, nx_state: state;
SIGNAL flag : STD_LOGIC;
begin

----- FLAG generator -----
PROCESS (clk, rst)
BEGIN
	IF (rst = '1') THEN
		flag <= '0';
	ELSIF (clk' EVENT AND clk ='1') THEN
		IF (remote = '0') THEN 
			flag <= '1';
		ELSE
			flag <= '0';
		END IF;
	END IF;
END PROCESS;

----- UPPER SECTION OF FSM  ----
PROCESS (clk, rst)
BEGIN 
	IF (rst = '1') THEN
		pre_state <= open_door;
	ELSIF (clk' EVENT AND clk ='1') THEN
		pre_state <= nx_state;
	END IF;
END PROCESS;
----- LOWER SECTION OF FSM  ----
PROCESS (pre_state, remote, sensor, flag)
BEGIN
	CASE pre_state IS
	
		when open_door => 
			alarm <= '0';
			IF ( remote = '1' AND flag = '1') THEN
				nx_state <= locked;
			ELSE 
				nx_state <= open_door;
			END IF;
			
		when locked => 
			alarm <= '0';
			IF ( remote = '1' AND flag = '1') THEN
				nx_state <= open_door;
			ELSIF ( sensor = '1') THEN
				nx_state <= theft;
			ELSE 
				nx_state <= locked;
			END IF;
			
		when theft => 
			alarm <= '1';
			IF ( remote = '1' AND flag = '1') THEN
				nx_state <= open_door;
			ELSE 
				nx_state <= theft;
			END IF;		
			
	END CASE;
END PROCESS;
end Behavioral;

