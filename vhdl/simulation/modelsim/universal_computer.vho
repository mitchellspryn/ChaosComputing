-- Copyright (C) 2020  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and any partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details, at
-- https://fpgasoftware.intel.com/eula.

-- VENDOR "Altera"
-- PROGRAM "Quartus Prime"
-- VERSION "Version 20.1.1 Build 720 11/11/2020 SJ Lite Edition"

-- DATE "07/11/2021 19:33:15"

-- 
-- Device: Altera EP4CE22F17C6 Package FBGA256
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY CYCLONEIVE;
LIBRARY IEEE;
USE CYCLONEIVE.CYCLONEIVE_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	hard_block IS
    PORT (
	devoe : IN std_logic;
	devclrn : IN std_logic;
	devpor : IN std_logic
	);
END hard_block;

-- Design Ports Information
-- ~ALTERA_ASDO_DATA1~	=>  Location: PIN_C1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ~ALTERA_FLASH_nCE_nCSO~	=>  Location: PIN_D2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ~ALTERA_DCLK~	=>  Location: PIN_H1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ~ALTERA_DATA0~	=>  Location: PIN_H2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ~ALTERA_nCEO~	=>  Location: PIN_F16,	 I/O Standard: 2.5 V,	 Current Strength: 8mA


ARCHITECTURE structure OF hard_block IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL \~ALTERA_ASDO_DATA1~~padout\ : std_logic;
SIGNAL \~ALTERA_FLASH_nCE_nCSO~~padout\ : std_logic;
SIGNAL \~ALTERA_DATA0~~padout\ : std_logic;
SIGNAL \~ALTERA_ASDO_DATA1~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_FLASH_nCE_nCSO~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_DATA0~~ibuf_o\ : std_logic;

BEGIN

ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
END structure;


LIBRARY CYCLONEIVE;
LIBRARY IEEE;
USE CYCLONEIVE.CYCLONEIVE_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	universal_computer IS
    PORT (
	in_a : IN std_logic_vector(1 DOWNTO 0);
	in_b : IN std_logic_vector(1 DOWNTO 0);
	add_not_mul : IN std_logic;
	output : BUFFER std_logic_vector(7 DOWNTO 0)
	);
END universal_computer;

-- Design Ports Information
-- output[0]	=>  Location: PIN_A15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[1]	=>  Location: PIN_A13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[2]	=>  Location: PIN_B13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[3]	=>  Location: PIN_A11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[4]	=>  Location: PIN_D1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[5]	=>  Location: PIN_F3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[6]	=>  Location: PIN_B1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[7]	=>  Location: PIN_L3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- add_not_mul	=>  Location: PIN_D9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- in_a[0]	=>  Location: PIN_E10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- in_b[0]	=>  Location: PIN_D11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- in_b[1]	=>  Location: PIN_B12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- in_a[1]	=>  Location: PIN_B11,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF universal_computer IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_in_a : std_logic_vector(1 DOWNTO 0);
SIGNAL ww_in_b : std_logic_vector(1 DOWNTO 0);
SIGNAL ww_add_not_mul : std_logic;
SIGNAL ww_output : std_logic_vector(7 DOWNTO 0);
SIGNAL \output[0]~output_o\ : std_logic;
SIGNAL \output[1]~output_o\ : std_logic;
SIGNAL \output[2]~output_o\ : std_logic;
SIGNAL \output[3]~output_o\ : std_logic;
SIGNAL \output[4]~output_o\ : std_logic;
SIGNAL \output[5]~output_o\ : std_logic;
SIGNAL \output[6]~output_o\ : std_logic;
SIGNAL \output[7]~output_o\ : std_logic;
SIGNAL \in_b[0]~input_o\ : std_logic;
SIGNAL \in_a[0]~input_o\ : std_logic;
SIGNAL \add_not_mul~input_o\ : std_logic;
SIGNAL \gen_gates:0:tmp_gate|Mux0~0_combout\ : std_logic;
SIGNAL \in_a[1]~input_o\ : std_logic;
SIGNAL \in_b[1]~input_o\ : std_logic;
SIGNAL \gen_gates:2:tmp_gate|Mux0~0_combout\ : std_logic;
SIGNAL \gen_gates:1:tmp_gate|output~0_combout\ : std_logic;
SIGNAL \gen_gates:4:tmp_gate|output~0_combout\ : std_logic;
SIGNAL \gen_gates:6:tmp_gate|Mux0~0_combout\ : std_logic;
SIGNAL \gen_gates:6:tmp_gate|Mux0~1_combout\ : std_logic;
SIGNAL \output~0_combout\ : std_logic;
SIGNAL \output~1_combout\ : std_logic;

COMPONENT hard_block
    PORT (
	devoe : IN std_logic;
	devclrn : IN std_logic;
	devpor : IN std_logic);
END COMPONENT;

BEGIN

ww_in_a <= in_a;
ww_in_b <= in_b;
ww_add_not_mul <= add_not_mul;
output <= ww_output;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
auto_generated_inst : hard_block
PORT MAP (
	devoe => ww_devoe,
	devclrn => ww_devclrn,
	devpor => ww_devpor);

-- Location: IOOBUF_X38_Y34_N16
\output[0]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \gen_gates:0:tmp_gate|Mux0~0_combout\,
	devoe => ww_devoe,
	o => \output[0]~output_o\);

-- Location: IOOBUF_X49_Y34_N2
\output[1]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \gen_gates:4:tmp_gate|output~0_combout\,
	devoe => ww_devoe,
	o => \output[1]~output_o\);

-- Location: IOOBUF_X49_Y34_N9
\output[2]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \gen_gates:6:tmp_gate|Mux0~1_combout\,
	devoe => ww_devoe,
	o => \output[2]~output_o\);

-- Location: IOOBUF_X40_Y34_N2
\output[3]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \output~1_combout\,
	devoe => ww_devoe,
	o => \output[3]~output_o\);

-- Location: IOOBUF_X0_Y25_N9
\output[4]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[4]~output_o\);

-- Location: IOOBUF_X0_Y26_N16
\output[5]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[5]~output_o\);

-- Location: IOOBUF_X0_Y28_N9
\output[6]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[6]~output_o\);

-- Location: IOOBUF_X0_Y10_N23
\output[7]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \output[7]~output_o\);

-- Location: IOIBUF_X51_Y34_N15
\in_b[0]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_in_b(0),
	o => \in_b[0]~input_o\);

-- Location: IOIBUF_X45_Y34_N15
\in_a[0]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_in_a(0),
	o => \in_a[0]~input_o\);

-- Location: IOIBUF_X31_Y34_N8
\add_not_mul~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_add_not_mul,
	o => \add_not_mul~input_o\);

-- Location: LCCOMB_X43_Y33_N16
\gen_gates:0:tmp_gate|Mux0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \gen_gates:0:tmp_gate|Mux0~0_combout\ = (\in_b[0]~input_o\ & (\in_a[0]~input_o\ $ (\add_not_mul~input_o\))) # (!\in_b[0]~input_o\ & (\in_a[0]~input_o\ & \add_not_mul~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100001101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \in_b[0]~input_o\,
	datab => \in_a[0]~input_o\,
	datac => \add_not_mul~input_o\,
	combout => \gen_gates:0:tmp_gate|Mux0~0_combout\);

-- Location: IOIBUF_X40_Y34_N8
\in_a[1]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_in_a(1),
	o => \in_a[1]~input_o\);

-- Location: IOIBUF_X43_Y34_N22
\in_b[1]~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_in_b(1),
	o => \in_b[1]~input_o\);

-- Location: LCCOMB_X43_Y33_N12
\gen_gates:2:tmp_gate|Mux0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \gen_gates:2:tmp_gate|Mux0~0_combout\ = (\add_not_mul~input_o\ & ((\in_a[1]~input_o\ $ (\in_b[1]~input_o\)))) # (!\add_not_mul~input_o\ & (\in_b[0]~input_o\ & (\in_a[1]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011100011001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \in_b[0]~input_o\,
	datab => \in_a[1]~input_o\,
	datac => \add_not_mul~input_o\,
	datad => \in_b[1]~input_o\,
	combout => \gen_gates:2:tmp_gate|Mux0~0_combout\);

-- Location: LCCOMB_X43_Y33_N26
\gen_gates:1:tmp_gate|output~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \gen_gates:1:tmp_gate|output~0_combout\ = (\in_a[0]~input_o\ & ((\add_not_mul~input_o\ & (\in_b[0]~input_o\)) # (!\add_not_mul~input_o\ & ((\in_b[1]~input_o\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \in_b[0]~input_o\,
	datab => \in_b[1]~input_o\,
	datac => \add_not_mul~input_o\,
	datad => \in_a[0]~input_o\,
	combout => \gen_gates:1:tmp_gate|output~0_combout\);

-- Location: LCCOMB_X43_Y33_N6
\gen_gates:4:tmp_gate|output~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \gen_gates:4:tmp_gate|output~0_combout\ = \gen_gates:2:tmp_gate|Mux0~0_combout\ $ (\gen_gates:1:tmp_gate|output~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \gen_gates:2:tmp_gate|Mux0~0_combout\,
	datac => \gen_gates:1:tmp_gate|output~0_combout\,
	combout => \gen_gates:4:tmp_gate|output~0_combout\);

-- Location: LCCOMB_X43_Y33_N24
\gen_gates:6:tmp_gate|Mux0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \gen_gates:6:tmp_gate|Mux0~0_combout\ = (\in_a[1]~input_o\ & \in_b[1]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \in_a[1]~input_o\,
	datad => \in_b[1]~input_o\,
	combout => \gen_gates:6:tmp_gate|Mux0~0_combout\);

-- Location: LCCOMB_X43_Y33_N10
\gen_gates:6:tmp_gate|Mux0~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \gen_gates:6:tmp_gate|Mux0~1_combout\ = (\gen_gates:6:tmp_gate|Mux0~0_combout\ & ((\add_not_mul~input_o\) # ((!\gen_gates:2:tmp_gate|Mux0~0_combout\) # (!\gen_gates:1:tmp_gate|output~0_combout\)))) # (!\gen_gates:6:tmp_gate|Mux0~0_combout\ & 
-- (((\gen_gates:1:tmp_gate|output~0_combout\ & \gen_gates:2:tmp_gate|Mux0~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011110011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \add_not_mul~input_o\,
	datab => \gen_gates:6:tmp_gate|Mux0~0_combout\,
	datac => \gen_gates:1:tmp_gate|output~0_combout\,
	datad => \gen_gates:2:tmp_gate|Mux0~0_combout\,
	combout => \gen_gates:6:tmp_gate|Mux0~1_combout\);

-- Location: LCCOMB_X43_Y33_N28
\output~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \output~0_combout\ = (\in_b[1]~input_o\ & (\in_b[0]~input_o\ & \in_a[0]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \in_b[1]~input_o\,
	datac => \in_b[0]~input_o\,
	datad => \in_a[0]~input_o\,
	combout => \output~0_combout\);

-- Location: LCCOMB_X43_Y33_N22
\output~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \output~1_combout\ = (\in_a[1]~input_o\ & (!\add_not_mul~input_o\ & \output~0_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \in_a[1]~input_o\,
	datac => \add_not_mul~input_o\,
	datad => \output~0_combout\,
	combout => \output~1_combout\);

ww_output(0) <= \output[0]~output_o\;

ww_output(1) <= \output[1]~output_o\;

ww_output(2) <= \output[2]~output_o\;

ww_output(3) <= \output[3]~output_o\;

ww_output(4) <= \output[4]~output_o\;

ww_output(5) <= \output[5]~output_o\;

ww_output(6) <= \output[6]~output_o\;

ww_output(7) <= \output[7]~output_o\;
END structure;


