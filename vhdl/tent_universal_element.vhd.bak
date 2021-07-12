library ieee;
use ieee.std_logic_1164.all;

-- This is weird because I don't have access to ieee_proposed in quartus light.
use ieee.numeric_std.all;

entity tent_universal_element is
	port
	(
		in_a : in std_logic;
		in_b : in std_logic;
		gate_sel : in std_logic_vector(2 downto 0);
		output  : out std_logic
	);
end tent_universal_element;

architecture behavorial of tent_universal_element is
signal a_input     : unsigned(2 downto 0);
signal b_input     : unsigned(2 downto 0);
signal x_0         : unsigned(2 downto 0);
signal x_c         : unsigned(2 downto 0);
signal accumulator : unsigned(2 downto 0);
signal chaotic     : unsigned(2 downto 0);

begin
	process (gate_sel) is
	begin
		case gate_sel is
			when "000" => --output <= in_a and in_b;
				x_0 <= "000"; -- 0.000
				x_c <= "010"; -- 0.250
			when "001" => --output <= in_a or in_b;
				x_0 <= "001"; -- 0.125
				x_c <= "001"; -- 0.125
			when "010" => --output <= in_a xor in_b;
				x_0 <= "010"; -- 0.250
				x_c <= "010"; -- 0.250
			when "011" => --in_a nand in_b
				x_0 <= "011"; -- 0.375 
				x_c <= "001"; -- 0.125
			when "100" => -- in_a nor in_b
				x_0 <= "100";
				x_c <= "010";
			when others => --output <= in_a xnor in_b;
				x_0 <= "110"; -- 0.000
				x_c <= "000"; -- 0.250
		end case;
	end process;

	process (in_a) is
	begin
		case in_a is
			when '1' => 
				a_input <= "010";
			when others => 
				a_input <= "000";
		end case;
	end process;
	
	process (in_b) is
	begin
		case in_b is
			when '1' => 
				b_input <= "010";
			when others => 
				b_input <= "000";
		end case;
	end process;
	
	process (a_input, b_input, x_0) is
	begin
		accumulator <= a_input + b_input + x_0;
	end process;
	
	process (accumulator) is
	begin
		case accumulator(2) is
			when '1' => 
				chaotic <= (not accumulator) + 1;
			when others =>
				chaotic <= accumulator;
		end case;
	end process;
	
	process (chaotic, x_c) is
	begin
		if (chaotic > x_c) then
			output <= '1';
		else
			output <= '0';
		end if;
	end process;
end architecture;