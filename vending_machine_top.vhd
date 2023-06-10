----------------------------------------------------------------------------------
-- Vending machine that 
-- takes 5, 10 or 25 tomans + a selector to chose a chocolate bar or a juice box  
-- gives out a chocolate bar or a juice box (25tomans both) 
-- also gives out 5 or 10 tomans as change
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity vending_machine_top is
    Port ( --- input ---
			  clk 	 : in  STD_LOGIC;
         --  rst 	 : in  STD_LOGIC;
           t_5_in  : in  STD_LOGIC;
           t_10_in : in  STD_LOGIC;
           t_25_in : in  STD_LOGIC;
           sel		 : in  STD_LOGIC; -- sel = 0 Chocolate bar / sel = 1 Juice box
			  --- output ---
           t_5_out   : inout  STD_LOGIC;
           t_10_out  : inout  STD_LOGIC;
           chocolate : inout  STD_LOGIC;
           juice 		: inout  STD_LOGIC);
end vending_machine_top;

architecture Behavioral of vending_machine_top is

TYPE state is (st5t_ch, st10t_ch, st15t_ch, st20t_ch, st25t_ch, st30t_ch, st35t_ch, st40t_ch, st45t_ch,
					st5t_ju, st10t_ju, st15t_ju, st20t_ju, st25t_ju, st30t_ju, st35t_ju, st40t_ju, st45t_ju,
					st0
					);
SIGNAL pre_state, nx_state : state;

begin
-------- Upper Section of FSM --------
Process (clk)
begin 
--	if (rst = '1') then       --- it was causing latch warnings!
--		pre_state <= st0;
	if (clk' event and clk ='1') then 
		pre_state <= nx_state;
	end if;
end process;

-------- Lower Section of FSM --------
process (pre_state, t_5_in, t_10_in, t_25_in, sel)
begin
	case pre_state is
		when st0 => 
			chocolate <= '0';
			juice 	 <= '0';
			t_5_out 	 <= '0';
			t_10_out  <= '0';
			if (t_5_in = '1' and sel = '0') then 
				nx_state <= st5t_ch;
			elsif (t_10_in = '1' and sel = '0') then 
				nx_state <= st10t_ch;
			elsif (t_25_in = '1' and sel = '0') then 
				nx_state <= st25t_ch;
			elsif (t_5_in = '1' and sel = '1') then 
				nx_state <= st5t_ju;
			elsif (t_10_in = '1' and sel = '1') then 
				nx_state <= st10t_ju;
			elsif (t_25_in = '1' and sel = '1') then 
				nx_state <= st25t_ju;
			else
				nx_state <= st0;
			end if;
------ CHOCOLATE ------
		when st5t_ch =>
		--	sel 		 <= '0';   NOT NEEDED
			chocolate <= '0';
			juice 	 <= '0';
			t_5_out 	 <= '0';
			t_10_out  <= '0';
			if (t_5_in = '1') then 
				nx_state <= st10t_ch;
			elsif (t_10_in = '1') then 
				nx_state <= st15t_ch;
			elsif (t_25_in = '1') then 
				nx_state <= st30t_ch;
			else
				nx_state <= st5t_ch;
			end if;
			
		when st10t_ch =>
		--	sel 		 <= '0';
			chocolate <= '0';
			juice 	 <= '0';
			t_5_out 	 <= '0';
			t_10_out  <= '0';
			if (t_5_in = '1') then 
				nx_state <= st15t_ch;
			elsif (t_10_in = '1') then 
				nx_state <= st20t_ch;
			elsif (t_25_in = '1') then 
				nx_state <= st35t_ch;
			else
				nx_state <= st10t_ch;
			end if;
			
		when st15t_ch =>
			--sel 		 <= '0';
			chocolate <= '0';
			juice 	 <= '0';
			t_5_out 	 <= '0';
			t_10_out  <= '0';
			if (t_5_in = '1') then 
				nx_state <= st20t_ch;
			elsif (t_10_in = '1') then 
				nx_state <= st25t_ch;
			elsif (t_25_in = '1') then 
				nx_state <= st40t_ch;
			else
				nx_state <= st15t_ch;
			end if;
		
		when st20t_ch =>
			--sel 		 <= '0';
			chocolate <= '0';
			juice 	 <= '0';
			t_5_out 	 <= '0';
			t_10_out  <= '0';
			if (t_5_in = '1') then 
				nx_state <= st25t_ch;
			elsif (t_10_in = '1') then 
				nx_state <= st30t_ch;
			elsif (t_25_in = '1') then 
				nx_state <= st45t_ch;
			else
				nx_state <= st20t_ch;
			end if;
		
		when st25t_ch =>
			--sel 		 <= '0';
			chocolate <= '1';
			juice 	 <= '0';
			t_5_out 	 <= '0';
			t_10_out  <= '0';
			nx_state <= st0;
		
		when st30t_ch =>
			--sel 		 <= '0';
			chocolate <= '1';
			juice 	 <= '0';
			t_5_out 	 <= '1';
			t_10_out  <= '0';
			nx_state <= st0;
			
			
		when st35t_ch =>
			--sel 		 <= '0';
			chocolate <= '1';
			juice 	 <= '0';
			t_5_out 	 <= '0';
			t_10_out  <= '1';
			nx_state <= st0;
		
		when st40t_ch =>
			--sel 		 <= '0';
			chocolate <= '1';
			juice 	 <= '0';
			t_5_out 	 <= '1';
			t_10_out  <= '0';
			nx_state <= st35t_ch;
		
		when st45t_ch =>
			--sel 		 <= '0';
			chocolate <= '1';
			juice 	 <= '0';
			t_5_out 	 <= '0';
			t_10_out  <= '1';
			nx_state <= st35t_ch;
			
------ JUICE ------- 
		when st5t_ju =>
			--sel 		 <= '1';
			chocolate <= '0';
			juice 	 <= '0';
			t_5_out 	 <= '0';
			t_10_out  <= '0';
			if (t_5_in = '1') then 
				nx_state <= st10t_ju;
			elsif (t_10_in = '1') then 
				nx_state <= st15t_ju;
			elsif (t_25_in = '1') then 
				nx_state <= st30t_ju;
			else
				nx_state <= st5t_ju;
			end if;
			
		when st10t_ju =>
			--sel 		 <= '1';
			chocolate <= '0';
			juice 	 <= '0';
			t_5_out 	 <= '0';
			t_10_out  <= '0';
			if (t_5_in = '1') then 
				nx_state <= st15t_ju;
			elsif (t_10_in = '1') then 
				nx_state <= st20t_ju;
			elsif (t_25_in = '1') then 
				nx_state <= st35t_ju;
			else
				nx_state <= st10t_ju;
			end if;
			
		when st15t_ju =>
			--sel 		 <= '1';
			chocolate <= '0';
			juice 	 <= '0';
			t_5_out 	 <= '0';
			t_10_out  <= '0';
			if (t_5_in = '1') then 
				nx_state <= st20t_ju;
			elsif (t_10_in = '1') then 
				nx_state <= st25t_ju;
			elsif (t_25_in = '1') then 
				nx_state <= st40t_ju;
			else
				nx_state <= st15t_ju;
			end if;
		
		when st20t_ju =>
			--sel 		 <= '1';
			chocolate <= '0';
			juice 	 <= '0';
			t_5_out 	 <= '0';
			t_10_out  <= '0';
			if (t_5_in = '1') then 
				nx_state <= st25t_ju;
			elsif (t_10_in = '1') then 
				nx_state <= st30t_ju;
			elsif (t_25_in = '1') then 
				nx_state <= st45t_ju;
			else
				nx_state <= st20t_ju;
			end if;
		
		when st25t_ju =>
			--sel 		 <= '1';
			chocolate <= '0';
			juice 	 <= '1';
			t_5_out 	 <= '0';
			t_10_out  <= '0';
			nx_state <= st0;
		
		when st30t_ju =>
			--sel 		 <= '1';
			chocolate <= '0';
			juice 	 <= '1';
			t_5_out 	 <= '1';
			t_10_out  <= '0';
			nx_state <= st0;
			
			
		when st35t_ju =>
			--sel 		 <= '1';
			chocolate <= '0';
			juice 	 <= '1';
			t_5_out 	 <= '0';
			t_10_out  <= '1';
			nx_state <= st0;
		
		when st40t_ju =>
			--sel 		 <= '1';
			chocolate <= '0';
			juice 	 <= '1';
			t_5_out 	 <= '1';
			t_10_out  <= '0';
			nx_state <= st35t_ju;
		
		when st45t_ju =>
			--sel 		 <= '1';
			chocolate <= '0';
			juice 	 <= '1';
			t_5_out 	 <= '0';
			t_10_out  <= '1';
			nx_state <= st35t_ju;
	end case;
end process;

end Behavioral;

