library ieee;
use ieee.std_logic_1164.all;

entity universal_gate_testbench is
end universal_gate_testbench;

architecture behavorial of universal_gate_testbench is
component brute_force_universal_element is
	port
	(
		in_a : in std_logic;
		in_b : in std_logic;
		gate_sel : in std_logic_vector(2 downto 0);
		output  : out std_logic
	);
end component;

component tent_universal_element is
	port
	(
		in_a : in std_logic;
		in_b : in std_logic;
		gate_sel : in std_logic_vector(2 downto 0);
		output  : out std_logic
	);
end component;

signal tb_a : std_logic := '0';
signal tb_b : std_logic := '0';
signal tb_o : std_logic := '0';
signal tb_gate_sel : std_logic_vector(2 downto 0) := "000";

-- It seems like modelsim only updates initial conditions when one of the signals changes. 
-- Create a dummy clock signal to force updates. 
signal dummy_clk : std_logic := '0';

constant cycle_period : time := 100 ns;
constant clock_cycle_period: time := 10 ns;

begin
	device_under_test : tent_universal_element 
	port map
	(
		in_a => tb_a,
		in_b => tb_b,
		gate_sel => tb_gate_sel,
		output => tb_o
	);
	
	process is
	begin
		dummy_clk <= not dummy_clk;
		wait for clock_cycle_period;
	end process;
	
	process is
	begin
		tb_a <= '0';
		tb_b <= '0';
		wait for cycle_period;
		
		tb_a <= '1';
		tb_b <= '0';
		wait for cycle_period;
		
		tb_a <= '0';
		tb_b <= '1';
		wait for cycle_period;
		
		tb_a <= '1';
		tb_b <= '1';
		wait for cycle_period;
	end process;
	
	process is
	begin
		tb_gate_sel <= "000";
		wait for 4 * cycle_period;
		
		
		tb_gate_sel <= "001";
		wait for 4 * cycle_period;
		
		
		tb_gate_sel <= "010";
		wait for 4 * cycle_period;
		
		
		tb_gate_sel <= "011";
		wait for 4 * cycle_period;
		
		
		tb_gate_sel <= "100";
		wait for 4 * cycle_period;
		
		
		tb_gate_sel <= "101";
		wait for 4 * cycle_period;
	end process;
end architecture;