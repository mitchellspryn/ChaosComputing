library ieee;
use ieee.std_logic_1164.all;

-- The chaotic lattice that serves as the top-level entity to be synthesized

entity universal_computer is
	port
	(
		in_a : in std_logic_vector(1 downto 0);
		in_b : in std_logic_vector(1 downto 0);
		add_not_mul : in std_logic;
		output : out std_logic_vector(7 downto 0)
	);
end universal_computer;

architecture behavorial of universal_computer is

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

type gate_sel_array is array (0 to 7) of std_logic_vector(2 downto 0);
signal gate_sel : gate_sel_array;

signal gate_sel_and : std_logic_vector(2 downto 0) := "000";
signal gate_sel_or : std_logic_vector(2 downto 0) := "001";
signal gate_sel_xor : std_logic_vector(2 downto 0) := "010";

signal out_vec : std_logic_vector(7 downto 0) := "00000000";
signal in_vec : std_logic_vector(15 downto 0) := "0000000000000000";

begin
	gen_gates : for i in 0 to 7 generate
		tmp_gate : brute_force_universal_element 
		port map
		(
			in_a => in_vec(2*i),
			in_b => in_vec((2*i) + 1),
			gate_sel => gate_sel(i),
			output => out_vec(i)
		);
	end generate gen_gates;

	process(in_a, in_b, gate_sel, add_not_mul)
	begin
		case add_not_mul is
			when '1' =>
				in_vec(0) <= in_a(0);
				in_vec(1) <= in_b(0);
				gate_sel(0) <= gate_sel_xor;
				
				in_vec(2) <= in_a(0);
				in_vec(3) <= in_b(0);
				gate_sel(1) <= gate_sel_and;
				
				in_vec(4) <= in_a(1);
				in_vec(5) <= in_b(1);
				gate_sel(2) <= gate_sel_xor;
				
				in_vec(6) <= in_a(1);
				in_vec(7) <= in_b(1);
				gate_sel(3) <= gate_sel_and;
				
				in_vec(8) <= out_vec(1);
				in_vec(9) <= out_vec(2);
				gate_sel(4) <= gate_sel_xor;
				
				in_vec(10) <= out_vec(1);
				in_vec(11) <= out_vec(2);
				gate_sel(5) <= gate_sel_and;
				
				in_vec(12) <= out_vec(5);
				in_vec(13) <= out_vec(3);
				gate_sel(6) <= gate_sel_or;
				
				-- This gate is unused
				in_vec(14) <= '0';
				in_vec(15) <= '0';
				gate_sel(7) <= gate_sel_and; 
				
				output <= "00000" & out_vec(6) & out_vec(4) & out_vec(0);
				
			when others =>
				in_vec(0) <= in_a(0);
				in_vec(1) <= in_b(0);
				gate_sel(0) <= gate_sel_and;
				
				in_vec(2) <= in_a(0);
				in_vec(3) <= in_b(1);
				gate_sel(1) <= gate_sel_and;
				
				in_vec(4) <= in_a(1);
				in_vec(5) <= in_b(0);
				gate_sel(2) <= gate_sel_and;
				
				in_vec(6) <= in_a(1);
				in_vec(7) <= in_b(1);
				gate_sel(3) <= gate_sel_and;
				
				in_vec(8) <= out_vec(1);
				in_vec(9) <= out_vec(2);
				gate_sel(4) <= gate_sel_xor;
				
				in_vec(10) <= out_vec(1);
				in_vec(11) <= out_vec(2);
				gate_sel(5) <= gate_sel_and;
				
				in_vec(12) <= out_vec(3);
				in_vec(13) <= out_vec(5);
				gate_sel(6) <= gate_sel_xor;
				
				in_vec(14) <= out_vec(3);
				in_vec(15) <= out_vec(5);
				gate_sel(7) <= gate_sel_and; 
				
				output <= "0000" & out_vec(7) & out_vec(6) & out_vec(4) & out_vec(0);
		end case;
	end process;
end architecture;