library ieee;
use ieee.std_logic_1164.all;

entity brute_force_universal_element is
	port
	(
		in_a : in std_logic;
		in_b : in std_logic;
		gate_sel : in std_logic_vector(2 downto 0);
		output  : out std_logic
	);
end brute_force_universal_element;

architecture behavorial of brute_force_universal_element is
begin
	process (gate_sel, in_a, in_b) is
	begin
		case gate_sel is
			when "000" => output <= in_a and in_b;
			when "001" => output <= in_a or in_b;
			when "010" => output <= in_a xor in_b;
			when "011" => output <= in_a nand in_b;
			when "100" => output <= in_a nor in_b;
			when others => output <= in_a xnor in_b;
		end case;
	end process;
end architecture;