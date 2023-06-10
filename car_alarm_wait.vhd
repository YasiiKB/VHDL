----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:13:19 05/30/2023 
-- Design Name: 
-- Module Name:    car_alarm_wait - Behavioral 
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

entity car_alarm_wait is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           remote : in  STD_LOGIC;
           sensor : in  STD_LOGIC;
           alarm : out  STD_LOGIC);
end car_alarm_wait;

architecture Behavioral of car_alarm_wait is

TYPE state is (open_door, wait1, locked, wait2, Theft, wait3);
SIGNAL pre_state, nx_state: state;

begin

----- Upper Section of fsm   -----
PROCESS (clk, rst) 
BEGIN 
	IF (rst = '1') THEN
		pre_state <= open_door;
	ELSIF ( clk' EVENT AND clk ='1') THEN 
		pre_state <= nx_state;
	END IF;
END PROCESS;

----- LOWER Section of fsm   -----
PROCESS (pre_state, remote, sensor)
BEGIN
	CASE pre_state IS
	
		WHEN open_door => 
			alarm <= '0';
			IF (remote ='1') THEN
				nx_state <= wait1;
			ELSE 
				nx_state <= open_door;
			END IF;
			
		WHEN wait1 =>
			alarm <= '0';
			IF (remote ='0') THEN
				nx_state <= locked;
			ELSE 
				nx_state <= wait1;
			END IF;
		
		WHEN locked =>
			alarm <= '0';
			IF (remote ='1') THEN
				nx_state <= wait2;
			ELSIF (sensor ='1') THEN
				nx_state <= theft;
			ELSE
				nx_state <= locked;
			END IF;
		
		WHEN wait2 => 
			alarm <= '0';
			IF (remote ='0') THEN
				nx_state <= open_door;
			ELSE 
				nx_state <= wait2;
			END IF;
		
		WHEN theft => 
			alarm <= '1';
			IF (remote ='1') THEN
				nx_state <= wait3;
			ELSE 
				nx_state <= theft;
			END IF;
		
		WHEN wait3 =>
			alarm <= '0';
			IF (remote ='0') THEN
				nx_state <= open_door;
			ELSE 
				nx_state <= wait3;
			END IF;
			
	END CASE; 
END PROCESS;
end Behavioral;

