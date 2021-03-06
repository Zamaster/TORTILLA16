-- megafunction wizard: %LPM_MUX%
-- GENERATION: STANDARD
-- VERSION: WM1.0
-- MODULE: LPM_MUX 

-- ============================================================
-- File Name: lpm_mux10.vhd
-- Megafunction Name(s):
-- 			LPM_MUX
--
-- Simulation Library Files(s):
-- 			lpm
-- ============================================================
-- ************************************************************
-- THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
--
-- 11.1 Build 259 01/25/2012 SP 2 SJ Full Version
-- ************************************************************


--Copyright (C) 1991-2011 Altera Corporation
--Your use of Altera Corporation's design tools, logic functions 
--and other software and tools, and its AMPP partner logic 
--functions, and any output files from any of the foregoing 
--(including device programming or simulation files), and any 
--associated documentation or information are expressly subject 
--to the terms and conditions of the Altera Program License 
--Subscription Agreement, Altera MegaCore Function License 
--Agreement, or other applicable license agreement, including, 
--without limitation, that your use is for the sole purpose of 
--programming logic devices manufactured by Altera and sold by 
--Altera or its authorized distributors.  Please refer to the 
--applicable agreement for further details.


LIBRARY ieee;
USE ieee.std_logic_1164.all;

LIBRARY lpm;
USE lpm.lpm_components.all;

ENTITY lpm_mux10 IS
	PORT
	(
		data0x		: IN STD_LOGIC_VECTOR (10 DOWNTO 0);
		data1x		: IN STD_LOGIC_VECTOR (10 DOWNTO 0);
		data2x		: IN STD_LOGIC_VECTOR (10 DOWNTO 0);
		sel		: IN STD_LOGIC_VECTOR (1 DOWNTO 0);
		result		: OUT STD_LOGIC_VECTOR (10 DOWNTO 0)
	);
END lpm_mux10;


ARCHITECTURE SYN OF lpm_mux10 IS

--	type STD_LOGIC_2D is array (NATURAL RANGE <>, NATURAL RANGE <>) of STD_LOGIC;

	SIGNAL sub_wire0	: STD_LOGIC_VECTOR (10 DOWNTO 0);
	SIGNAL sub_wire1	: STD_LOGIC_VECTOR (10 DOWNTO 0);
	SIGNAL sub_wire2	: STD_LOGIC_2D (2 DOWNTO 0, 10 DOWNTO 0);
	SIGNAL sub_wire3	: STD_LOGIC_VECTOR (10 DOWNTO 0);
	SIGNAL sub_wire4	: STD_LOGIC_VECTOR (10 DOWNTO 0);

BEGIN
	sub_wire4    <= data0x(10 DOWNTO 0);
	sub_wire3    <= data1x(10 DOWNTO 0);
	result    <= sub_wire0(10 DOWNTO 0);
	sub_wire1    <= data2x(10 DOWNTO 0);
	sub_wire2(2, 0)    <= sub_wire1(0);
	sub_wire2(2, 1)    <= sub_wire1(1);
	sub_wire2(2, 2)    <= sub_wire1(2);
	sub_wire2(2, 3)    <= sub_wire1(3);
	sub_wire2(2, 4)    <= sub_wire1(4);
	sub_wire2(2, 5)    <= sub_wire1(5);
	sub_wire2(2, 6)    <= sub_wire1(6);
	sub_wire2(2, 7)    <= sub_wire1(7);
	sub_wire2(2, 8)    <= sub_wire1(8);
	sub_wire2(2, 9)    <= sub_wire1(9);
	sub_wire2(2, 10)    <= sub_wire1(10);
	sub_wire2(1, 0)    <= sub_wire3(0);
	sub_wire2(1, 1)    <= sub_wire3(1);
	sub_wire2(1, 2)    <= sub_wire3(2);
	sub_wire2(1, 3)    <= sub_wire3(3);
	sub_wire2(1, 4)    <= sub_wire3(4);
	sub_wire2(1, 5)    <= sub_wire3(5);
	sub_wire2(1, 6)    <= sub_wire3(6);
	sub_wire2(1, 7)    <= sub_wire3(7);
	sub_wire2(1, 8)    <= sub_wire3(8);
	sub_wire2(1, 9)    <= sub_wire3(9);
	sub_wire2(1, 10)    <= sub_wire3(10);
	sub_wire2(0, 0)    <= sub_wire4(0);
	sub_wire2(0, 1)    <= sub_wire4(1);
	sub_wire2(0, 2)    <= sub_wire4(2);
	sub_wire2(0, 3)    <= sub_wire4(3);
	sub_wire2(0, 4)    <= sub_wire4(4);
	sub_wire2(0, 5)    <= sub_wire4(5);
	sub_wire2(0, 6)    <= sub_wire4(6);
	sub_wire2(0, 7)    <= sub_wire4(7);
	sub_wire2(0, 8)    <= sub_wire4(8);
	sub_wire2(0, 9)    <= sub_wire4(9);
	sub_wire2(0, 10)    <= sub_wire4(10);

	LPM_MUX_component : LPM_MUX
	GENERIC MAP (
		lpm_size => 3,
		lpm_type => "LPM_MUX",
		lpm_width => 11,
		lpm_widths => 2
	)
	PORT MAP (
		data => sub_wire2,
		sel => sel,
		result => sub_wire0
	);



END SYN;

-- ============================================================
-- CNX file retrieval info
-- ============================================================
-- Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Cyclone IV E"
-- Retrieval info: PRIVATE: SYNTH_WRAPPER_GEN_POSTFIX STRING "0"
-- Retrieval info: PRIVATE: new_diagram STRING "1"
-- Retrieval info: LIBRARY: lpm lpm.lpm_components.all
-- Retrieval info: CONSTANT: LPM_SIZE NUMERIC "3"
-- Retrieval info: CONSTANT: LPM_TYPE STRING "LPM_MUX"
-- Retrieval info: CONSTANT: LPM_WIDTH NUMERIC "11"
-- Retrieval info: CONSTANT: LPM_WIDTHS NUMERIC "2"
-- Retrieval info: USED_PORT: data0x 0 0 11 0 INPUT NODEFVAL "data0x[10..0]"
-- Retrieval info: USED_PORT: data1x 0 0 11 0 INPUT NODEFVAL "data1x[10..0]"
-- Retrieval info: USED_PORT: data2x 0 0 11 0 INPUT NODEFVAL "data2x[10..0]"
-- Retrieval info: USED_PORT: result 0 0 11 0 OUTPUT NODEFVAL "result[10..0]"
-- Retrieval info: USED_PORT: sel 0 0 2 0 INPUT NODEFVAL "sel[1..0]"
-- Retrieval info: CONNECT: @data 1 0 11 0 data0x 0 0 11 0
-- Retrieval info: CONNECT: @data 1 1 11 0 data1x 0 0 11 0
-- Retrieval info: CONNECT: @data 1 2 11 0 data2x 0 0 11 0
-- Retrieval info: CONNECT: @sel 0 0 2 0 sel 0 0 2 0
-- Retrieval info: CONNECT: result 0 0 11 0 @result 0 0 11 0
-- Retrieval info: GEN_FILE: TYPE_NORMAL lpm_mux10.vhd TRUE
-- Retrieval info: GEN_FILE: TYPE_NORMAL lpm_mux10.inc FALSE
-- Retrieval info: GEN_FILE: TYPE_NORMAL lpm_mux10.cmp TRUE
-- Retrieval info: GEN_FILE: TYPE_NORMAL lpm_mux10.bsf TRUE FALSE
-- Retrieval info: GEN_FILE: TYPE_NORMAL lpm_mux10_inst.vhd FALSE
-- Retrieval info: LIB_FILE: lpm
