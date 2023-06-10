----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:23:18 05/14/2023 
-- Design Name: 
-- Module Name:    circular_shift - Behavioral 
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

entity circular_shift is
    Port ( clk  : in  STD_LOGIC;
           load : in  STD_LOGIC;
           d 	 : in  STD_LOGIC_VECTOR (3 downto 0);
           q 	 : out STD_LOGIC_VECTOR (3 downto 0));
end circular_shift;

architecture Behavioral of circular_shift is

SIGNAL i 	 : STD_LOGIC_VECTOR (3 downto 0);
SIGNAL q_int : STD_LOGIC_VECTOR (3 downto 0);

--- D flip flop Component ---
component dflipflop is
    Port ( d : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           q : out  STD_LOGIC);
end component;

--- Mux Component ---
component mux is
    Port ( a : in  STD_LOGIC;
           b : in  STD_LOGIC;
           sel : in  STD_LOGIC;
           x : out  STD_LOGIC);
end component;

begin
--- Instantation ---
mux1: mux PORT MAP(a => q_int(3), b => d(0), sel => load, x => i(0));
mux2: mux PORT MAP(a => q_int(0), b => d(1), sel => load, x => i(1));
mux3: mux PORT MAP(a => q_int(1), b => d(2), sel => load, x => i(2));
mux4: mux PORT MAP(a => q_int(2), b => d(3), sel => load, x => i(3));
dff1: dflipflop PORT MAP (d => i(0), clk => clk, q => q_int(0), rst => '0');
dff2: dflipflop PORT MAP (d => i(1), clk => clk, q => q_int(1), rst => '0');
dff3: dflipflop PORT MAP (d => i(2), clk => clk, q => q_int(2), rst => '0');
dff4: dflipflop PORT MAP (d => i(3), clk => clk, q => q_int(3), rst => '0');

q <= q_int;

end Behavioral;

