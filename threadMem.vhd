-- Copyright (C) 1991-2011 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- PROGRAM		"Quartus II 64-Bit"
-- VERSION		"Version 11.1 Build 259 01/25/2012 Service Pack 2 SJ Full Version"
-- CREATED		"Wed Dec 10 23:32:24 2014"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY threadMem IS 
	PORT
	(
		clk :  IN  STD_LOGIC;
		mode :  IN  STD_LOGIC;
		rst :  IN  STD_LOGIC;
		rw :  IN  STD_LOGIC;
		rw_long :  IN  STD_LOGIC;
		stack_page :  IN  STD_LOGIC;
		offset_en :  IN  STD_LOGIC;
		addr :  IN  STD_LOGIC_VECTOR(10 DOWNTO 0);
		data :  IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
		long_data :  IN  STD_LOGIC_VECTOR(10 DOWNTO 0);
		offset :  IN  STD_LOGIC_VECTOR(7 DOWNTO 0);
		thread :  IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
		ind_result :  OUT  STD_LOGIC_VECTOR(15 DOWNTO 0);
		result :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END threadMem;

ARCHITECTURE bdf_type OF threadMem IS 

COMPONENT coreram
	PORT(clock : IN STD_LOGIC;
		 wren_a : IN STD_LOGIC;
		 wren_b : IN STD_LOGIC;
		 address_a : IN STD_LOGIC_VECTOR(13 DOWNTO 0);
		 address_b : IN STD_LOGIC_VECTOR(14 DOWNTO 0);
		 data_a : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 data_b : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 q_a : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		 q_b : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT multi_gnd
GENERIC (BIT_WIDTH : INTEGER
			);
	PORT(		 q : OUT STD_LOGIC_VECTOR(BIT_WIDTH-1 DOWNTO 0)
	);
END COMPONENT;

COMPONENT lpm_constant9
	PORT(		 result : OUT STD_LOGIC_VECTOR(10 DOWNTO 0)
	);
END COMPONENT;

COMPONENT lpm_add_sub2
	PORT(dataa : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		 datab : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		 result : OUT STD_LOGIC_VECTOR(10 DOWNTO 0)
	);
END COMPONENT;

COMPONENT lpm_mux7
	PORT(sel : IN STD_LOGIC;
		 data0x : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 data1x : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 result : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT lpm_constant7
	PORT(		 result : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT lpm_mux15
	PORT(sel : IN STD_LOGIC;
		 data0x : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		 data1x : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		 result : OUT STD_LOGIC_VECTOR(10 DOWNTO 0)
	);
END COMPONENT;

COMPONENT d_ff_vhdl
GENERIC (BIT_WIDTH : INTEGER
			);
	PORT(clk : IN STD_LOGIC;
		 rst : IN STD_LOGIC;
		 ce : IN STD_LOGIC;
		 d : IN STD_LOGIC_VECTOR(BIT_WIDTH-1 DOWNTO 0);
		 q : OUT STD_LOGIC_VECTOR(BIT_WIDTH-1 DOWNTO 0)
	);
END COMPONENT;

COMPONENT lpm_mux4
	PORT(sel : IN STD_LOGIC;
		 data0x : IN STD_LOGIC_VECTOR(14 DOWNTO 0);
		 data1x : IN STD_LOGIC_VECTOR(14 DOWNTO 0);
		 result : OUT STD_LOGIC_VECTOR(14 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	addr_a :  STD_LOGIC_VECTOR(14 DOWNTO 0);
SIGNAL	addr_a_off :  STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL	data_in :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	grounded :  STD_LOGIC;
SIGNAL	long_data_in :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	mode_in :  STD_LOGIC;
SIGNAL	offset_in :  STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL	offset_in_pre :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	out_mem :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	out_prim_hold :  STD_LOGIC_VECTOR(14 DOWNTO 0);
SIGNAL	q_a_out :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	res_split :  STD_LOGIC_VECTOR(23 DOWNTO 0);
SIGNAL	rw_in :  STD_LOGIC;
SIGNAL	stage1_out :  STD_LOGIC_VECTOR(24 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC_VECTOR(14 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_3 :  STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_7 :  STD_LOGIC;

SIGNAL	GDFX_TEMP_SIGNAL_3 :  STD_LOGIC_VECTOR(14 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_4 :  STD_LOGIC_VECTOR(14 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_2 :  STD_LOGIC_VECTOR(23 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_1 :  STD_LOGIC_VECTOR(24 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_0 :  STD_LOGIC_VECTOR(10 DOWNTO 0);

BEGIN 
SYNTHESIZED_WIRE_7 <= '1';

GDFX_TEMP_SIGNAL_3 <= (stage1_out(14 DOWNTO 11) & q_a_out(10 DOWNTO 0));
GDFX_TEMP_SIGNAL_4 <= (stage1_out(14 DOWNTO 11) & q_a_out(10 DOWNTO 0));
GDFX_TEMP_SIGNAL_2 <= (grounded & out_prim_hold(14 DOWNTO 0) & out_mem(7 DOWNTO 0));
GDFX_TEMP_SIGNAL_1 <= (mode_in & data_in(7 DOWNTO 0) & rw_in & addr_a(14 DOWNTO 0));
GDFX_TEMP_SIGNAL_0 <= (offset_in(10 DOWNTO 8) & offset_in(7 DOWNTO 0));


b2v_inst : coreram
PORT MAP(clock => clk,
		 wren_a => rw_long,
		 wren_b => stage1_out(15),
		 address_a => addr_a(14 DOWNTO 1),
		 address_b => SYNTHESIZED_WIRE_0,
		 data_a => long_data_in,
		 data_b => stage1_out(23 DOWNTO 16),
		 q_a => q_a_out,
		 q_b => out_mem);


b2v_inst10 : multi_gnd
GENERIC MAP(BIT_WIDTH => 1
			)
PORT MAP(		 q(0) => grounded);


b2v_inst11 : multi_gnd
GENERIC MAP(BIT_WIDTH => 5
			)
PORT MAP(		 q => long_data_in(15 DOWNTO 11));


b2v_inst12 : lpm_constant9
PORT MAP(		 result => SYNTHESIZED_WIRE_3);


b2v_inst13 : lpm_add_sub2
PORT MAP(dataa => SYNTHESIZED_WIRE_1,
		 datab => GDFX_TEMP_SIGNAL_0,
		 result => addr_a(10 DOWNTO 0));


b2v_inst14 : lpm_mux7
PORT MAP(sel => offset_en,
		 data0x => SYNTHESIZED_WIRE_2,
		 data1x => offset_in_pre,
		 result => offset_in(7 DOWNTO 0));


b2v_inst15 : lpm_constant7
PORT MAP(		 result => SYNTHESIZED_WIRE_2);


b2v_inst2 : lpm_mux15
PORT MAP(sel => stack_page,
		 data0x => addr_a_off,
		 data1x => SYNTHESIZED_WIRE_3,
		 result => SYNTHESIZED_WIRE_1);


b2v_inst3 : d_ff_vhdl
GENERIC MAP(BIT_WIDTH => 25
			)
PORT MAP(clk => clk,
		 rst => rst,
		 ce => SYNTHESIZED_WIRE_7,
		 d => GDFX_TEMP_SIGNAL_1,
		 q => stage1_out);


b2v_inst4 : d_ff_vhdl
GENERIC MAP(BIT_WIDTH => 24
			)
PORT MAP(clk => clk,
		 rst => rst,
		 ce => SYNTHESIZED_WIRE_7,
		 d => GDFX_TEMP_SIGNAL_2,
		 q => res_split);



b2v_inst6 : d_ff_vhdl
GENERIC MAP(BIT_WIDTH => 15
			)
PORT MAP(clk => clk,
		 rst => rst,
		 ce => SYNTHESIZED_WIRE_7,
		 d => GDFX_TEMP_SIGNAL_3,
		 q => out_prim_hold);


b2v_inst7 : lpm_mux4
PORT MAP(sel => stage1_out(24),
		 data0x => stage1_out(14 DOWNTO 0),
		 data1x => GDFX_TEMP_SIGNAL_4,
		 result => SYNTHESIZED_WIRE_0);


b2v_inst9 : multi_gnd
GENERIC MAP(BIT_WIDTH => 3
			)
PORT MAP(		 q => offset_in(10 DOWNTO 8));

ind_result(15 DOWNTO 0) <= res_split(23 DOWNTO 8);
mode_in <= mode;
data_in <= data;
rw_in <= rw;
addr_a_off <= addr;
offset_in_pre <= offset;
result(7 DOWNTO 0) <= res_split(7 DOWNTO 0);

addr_a(14 DOWNTO 11) <= thread;
long_data_in(10 DOWNTO 0) <= long_data;
END bdf_type;