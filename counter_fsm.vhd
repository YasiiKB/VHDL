----------------------------------------------------------------------------------
-- A counter that counts from 0 to 9 and shows the number on a 7-seg every one minute. (Up counter) 
-- When it gets to 9, it counts downwards to 0. (Down Counter)  
-- using FINITE STATE MACHINES
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.counter_fsm_package.ALL;

entity counter_fsm is
	 GENERIC (tfinal : INTEGER := 2);
    Port ( clk  : in   STD_LOGIC;
           rst  : in   STD_LOGIC;
           sseg : out  STD_LOGIC_VECTOR (7 downto 0);
           COM  : out  STD_LOGIC_VECTOR (3 downto 0);
			  output : out INTEGER RANGE 0 to 9   -- for testbench
			  );
end counter_fsm;

architecture Behavioral of counter_fsm is


begin

------------- INSTANTIATION ----- 
your_instance_name : counter_fsm_clock
  port map
   (-- Clock in ports
    CLK_IN1 => clk,
    -- Clock out ports
    CLK_OUT1 => updated_clk);
------------- End INSTANTIATION  ------------

------------- Upper Section of FSM ----------
PROCESS (updated_clk, rst)
VARIABLE count : INTEGER RANGE 0 to tfinal;
BEGIN
	IF (rst = '0') THEN 
		pre_state <= zero;
		count := 0;
	ELSIF (updated_clk' EVENT AND updated_clk = '1') THEN 
		count := count + 1;
		IF (count = tfinal) THEN
			count := 0;
			pre_state <= nx_state;
		END IF;
	END IF;		
END PROCESS;

------------- Lower Section of FSM ----------
COM <= "0111";
PROCESS (pre_state)
variable flag : STD_LOGIC := '1'; -- flag = 1 : upward 
BEGIN 

CASE pre_state IS

	WHEN zero => 
		sseg <= "11000000";
		output <= 0 ;  
		flag := '1';
		nx_state <= one;		
		
	WHEN one => 
		sseg <= "11111001";
		output <= 1 ;
		IF (flag ='1') THEN 
			nx_state <= two;
		ELSE
			nx_state <= zero;
		END IF; 
		
	WHEN two => 
		sseg <= "10100100";
		output <= 2 ;
		IF (flag ='1') THEN 
			nx_state <= three;
		ELSE
			nx_state <= one;
		END IF; 
		
	WHEN three => 
		sseg <= "10110000";
		output <= 3 ;
		IF (flag ='1') THEN 
			nx_state <= four;
		ELSE
			nx_state <= two;
		END IF; 
		
	WHEN four => 
		sseg <= "10011001";
		output <= 4 ;
		IF (flag ='1') THEN 
			nx_state <= five;
		ELSE
			nx_state <= three;
		END IF; 
		
	WHEN five => 
		sseg <= "10010010";
		output <= 5;
		IF (flag ='1') THEN 
			nx_state <= six;
		ELSE
			nx_state <= four;
		END IF; 
		
	WHEN six => 
		sseg <= "10000010";
		output <= 6 ;
		IF (flag ='1') THEN 
			nx_state <= seven;
		ELSE
			nx_state <= five;
		END IF; 
		
	WHEN seven => 
		sseg <= "11111000";
		output <= 7 ;
		IF (flag ='1') THEN 
			nx_state <= eight;
		ELSE
			nx_state <= six;
		END IF; 
		
	WHEN eight => 
		sseg <= "10000000";
		output <= 8 ;
		IF (flag ='1') THEN 
			nx_state <= nine;
		ELSE
			nx_state <= seven;
		END IF; 
		
	WHEN nine =>
		sseg <= "10010000";
		output <= 9 ;
		flag := '0';
		nx_state <= eight;
		
END CASE; 
END PROCESS;
end Behavioral;

