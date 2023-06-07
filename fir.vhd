-- megafunction wizard: %FIR Compiler v13.0%
-- GENERATION: XML

-- ============================================================
-- Megafunction Name(s):
-- 			fir_ast
-- ============================================================
-- Generated by FIR Compiler 13.0 [Altera, IP Toolbench 1.3.0 Build 232]
-- ************************************************************
-- THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
-- ************************************************************
-- Copyright (C) 1991-2023 Altera Corporation
-- Any megafunction design, and related net list (encrypted or decrypted),
-- support information, device programming or simulation file, and any other
-- associated documentation or information provided by Altera or a partner
-- under Altera's Megafunction Partnership Program may be used only to
-- program PLD devices (but not masked PLD devices) from Altera.  Any other
-- use of such megafunction design, net list, support information, device
-- programming or simulation file, or any other related documentation or
-- information is prohibited for any other purpose, including, but not
-- limited to modification, reverse engineering, de-compiling, or use with
-- any other silicon devices, unless such use is explicitly licensed under
-- a separate agreement with Altera or a megafunction partner.  Title to
-- the intellectual property, including patents, copyrights, trademarks,
-- trade secrets, or maskworks, embodied in any such megafunction design,
-- net list, support information, device programming or simulation file, or
-- any other related documentation or information provided by Altera or a
-- megafunction partner, remains with Altera, the megafunction partner, or
-- their respective licensors.  No other licenses, including any licenses
-- needed under any third party's intellectual property, are provided herein.

library IEEE;
use IEEE.std_logic_1164.all;

ENTITY fir IS
	PORT (
		clk	: IN STD_LOGIC;
		reset_n	: IN STD_LOGIC;
		ast_sink_data	: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
		ast_sink_valid	: IN STD_LOGIC;
		ast_source_ready	: IN STD_LOGIC;
		ast_sink_sop	: IN STD_LOGIC;
		ast_sink_eop	: IN STD_LOGIC;
		ast_sink_error	: IN STD_LOGIC_VECTOR (1 DOWNTO 0);
		ast_source_data	: OUT STD_LOGIC_VECTOR (35 DOWNTO 0);
		ast_sink_ready	: OUT STD_LOGIC;
		ast_source_valid	: OUT STD_LOGIC;
		ast_source_sop	: OUT STD_LOGIC;
		ast_source_eop	: OUT STD_LOGIC;
		ast_source_channel	: OUT STD_LOGIC;
		ast_source_error	: OUT STD_LOGIC_VECTOR (1 DOWNTO 0)
	);
END fir;

ARCHITECTURE SYN OF fir IS


	COMPONENT fir_ast
	PORT (
		clk	: IN STD_LOGIC;
		reset_n	: IN STD_LOGIC;
		ast_sink_data	: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
		ast_sink_valid	: IN STD_LOGIC;
		ast_source_ready	: IN STD_LOGIC;
		ast_sink_sop	: IN STD_LOGIC;
		ast_sink_eop	: IN STD_LOGIC;
		ast_sink_error	: IN STD_LOGIC_VECTOR (1 DOWNTO 0);
		ast_source_data	: OUT STD_LOGIC_VECTOR (35 DOWNTO 0);
		ast_sink_ready	: OUT STD_LOGIC;
		ast_source_valid	: OUT STD_LOGIC;
		ast_source_sop	: OUT STD_LOGIC;
		ast_source_eop	: OUT STD_LOGIC;
		ast_source_channel	: OUT STD_LOGIC;
		ast_source_error	: OUT STD_LOGIC_VECTOR (1 DOWNTO 0)
	);

	END COMPONENT;

BEGIN

	fir_ast_inst : fir_ast
	PORT MAP (
		clk  =>  clk,
		reset_n  =>  reset_n,
		ast_sink_data  =>  ast_sink_data,
		ast_source_data  =>  ast_source_data,
		ast_sink_valid  =>  ast_sink_valid,
		ast_sink_ready  =>  ast_sink_ready,
		ast_source_valid  =>  ast_source_valid,
		ast_source_ready  =>  ast_source_ready,
		ast_sink_sop  =>  ast_sink_sop,
		ast_sink_eop  =>  ast_sink_eop,
		ast_source_sop  =>  ast_source_sop,
		ast_source_eop  =>  ast_source_eop,
		ast_source_channel  =>  ast_source_channel,
		ast_sink_error  =>  ast_sink_error,
		ast_source_error  =>  ast_source_error
	);


END SYN;


-- =========================================================
-- FIR Compiler Wizard Data
-- ===============================
-- DO NOT EDIT FOLLOWING DATA
-- @Altera, IP Toolbench@
-- Warning: If you modify this section, FIR Compiler Wizard may not be able to reproduce your chosen configuration.
-- 
-- Retrieval info: <?xml version="1.0"?>
-- Retrieval info: <MEGACORE title="FIR Compiler"  version="13.0"  build="232"  iptb_version="1.3.0 Build 232"  format_version="120" >
-- Retrieval info:  <NETLIST_SECTION class="altera.ipbu.flowbase.netlist.model.FIRModelClass"  active_core="fir_ast" >
-- Retrieval info:   <STATIC_SECTION>
-- Retrieval info:    <PRIVATES>
-- Retrieval info:     <NAMESPACE name = "parameterization">
-- Retrieval info:      <PRIVATE name = "use_mem" value="1"  type="BOOLEAN"  enable="1" />
-- Retrieval info:      <PRIVATE name = "mem_type" value="M512"  type="STRING"  enable="1" />
-- Retrieval info:      <PRIVATE name = "filter_rate" value="Single Rate"  type="STRING"  enable="1" />
-- Retrieval info:      <PRIVATE name = "filter_factor" value="2"  type="INTEGER"  enable="0" />
-- Retrieval info:      <PRIVATE name = "coefficient_scaling_type" value="Auto"  type="STRING"  enable="1" />
-- Retrieval info:      <PRIVATE name = "coefficient_scaling_factor" value="453835.90763687534"  type="STRING"  enable="0" />
-- Retrieval info:      <PRIVATE name = "coefficient_bit_width" value="16"  type="INTEGER"  enable="1" />
-- Retrieval info:      <PRIVATE name = "coefficient_binary_point_position" value="0"  type="INTEGER"  enable="0" />
-- Retrieval info:      <PRIVATE name = "number_of_input_channels" value="2"  type="INTEGER"  enable="1" />
-- Retrieval info:      <PRIVATE name = "input_number_system" value="Signed Binary"  type="STRING"  enable="1" />
-- Retrieval info:      <PRIVATE name = "input_bit_width" value="16"  type="INTEGER"  enable="1" />
-- Retrieval info:      <PRIVATE name = "input_binary_point_position" value="0"  type="INTEGER"  enable="0" />
-- Retrieval info:      <PRIVATE name = "output_bit_width_method" value="Actual Coefficients"  type="STRING"  enable="1" />
-- Retrieval info:      <PRIVATE name = "output_number_system" value="Full Resolution"  type="STRING"  enable="1" />
-- Retrieval info:      <PRIVATE name = "output_bit_width" value="36"  type="INTEGER"  enable="1" />
-- Retrieval info:      <PRIVATE name = "output_bits_right_of_binary_point" value="30"  type="INTEGER"  enable="0" />
-- Retrieval info:      <PRIVATE name = "output_bits_removed_from_lsb" value="0"  type="INTEGER"  enable="0" />
-- Retrieval info:      <PRIVATE name = "output_lsb_remove_type" value="Truncate"  type="STRING"  enable="1" />
-- Retrieval info:      <PRIVATE name = "output_msb_remove_type" value="Truncate"  type="STRING"  enable="1" />
-- Retrieval info:      <PRIVATE name = "flow_control" value="0"  type="INTEGER"  enable="1" />
-- Retrieval info:      <PRIVATE name = "flow_control_input" value="Slave Sink"  type="STRING"  enable="1" />
-- Retrieval info:      <PRIVATE name = "flow_control_output" value="Master Source"  type="STRING"  enable="1" />
-- Retrieval info:      <PRIVATE name = "device_family" value="Cyclone II"  type="STRING"  enable="1" />
-- Retrieval info:      <PRIVATE name = "structure" value="Variable/Fixed Coefficient : Multi-Cycle"  type="STRING"  enable="1" />
-- Retrieval info:      <PRIVATE name = "pipeline_level" value="2"  type="INTEGER"  enable="1" />
-- Retrieval info:      <PRIVATE name = "clocks_to_compute" value="1"  type="INTEGER"  enable="1" />
-- Retrieval info:      <PRIVATE name = "number_of_serial_units" value="2"  type="INTEGER"  enable="0" />
-- Retrieval info:      <PRIVATE name = "data_storage" value="Logic Cells"  type="STRING"  enable="1" />
-- Retrieval info:      <PRIVATE name = "coefficient_storage" value="Logic Cells"  type="STRING"  enable="1" />
-- Retrieval info:      <PRIVATE name = "multiplier_storage" value="DSP Blocks"  type="STRING"  enable="1" />
-- Retrieval info:      <PRIVATE name = "force_non_symmetric_structure" value="1"  type="BOOLEAN"  enable="1" />
-- Retrieval info:      <PRIVATE name = "coefficients_reload" value="0"  type="BOOLEAN"  enable="1" />
-- Retrieval info:      <PRIVATE name = "coefficients_reload_sgl_clock" value="0"  type="BOOLEAN"  enable="1" />
-- Retrieval info:      <PRIVATE name = "max_clocks_to_compute" value="4"  type="INTEGER"  enable="1" />
-- Retrieval info:      <PRIVATE name = "set_1" value="FPF, Imported, D:\altera\13.0sp1\projects\final_project\filter_coefficients.txt, -1.595245E-4, -3.084001E-4, -4.301811E-4, -4.347041E-4, -2.055598E-4, 3.800131E-4, 0.0014207502, 0.002954522, 0.0049219066, 0.0071389554, 0.009288238, 0.010935514, 0.011575574, 0.010705391, 0.007916563, 0.00299339, -0.0040009534, -0.012668682, -0.022268087, -0.031760525, -0.03991478, -0.045459464, -0.04726445, -0.04452472, -0.03691673, -0.024698963, -0.008735336, 0.00956884, 0.02841474, 0.045824185, 0.05989078, 0.06903141, 0.072200105, 0.06903141, 0.05989078, 0.045824185, 0.02841474, 0.00956884, -0.008735336, -0.024698963, -0.03691673, -0.04452472, -0.04726445, -0.045459464, -0.03991478, -0.031760525, -0.022268087, -0.012668682, -0.0040009534, 0.00299339, 0.007916563, 0.010705391, 0.011575574, 0.010935514, 0.009288238, 0.0071389554, 0.0049219066, 0.002954522, 0.0014207502, 3.800131E-4, -2.055598E-4, -4.347041E-4, -4.301811E-4, -3.084001E-4, -1.595245E-4"  type="STRING"  enable="1" />
-- Retrieval info:      <PRIVATE name = "number_of_sets" value="1"  type="INTEGER"  enable="1" />
-- Retrieval info:      <PRIVATE name = "output_full_bit_width" value="36"  type="INTEGER"  enable="1" />
-- Retrieval info:      <PRIVATE name = "output_full_bits_right_of_binary_point" value="30"  type="INTEGER"  enable="1" />
-- Retrieval info:      <PRIVATE name = "coefficient_reload_bit_width" value="11"  type="INTEGER"  enable="1" />
-- Retrieval info:      <PRIVATE name = "logic_cell" value="6994"  type="INTEGER"  enable="1" />
-- Retrieval info:      <PRIVATE name = "m512" value="0"  type="INTEGER"  enable="1" />
-- Retrieval info:      <PRIVATE name = "m4k" value="0"  type="INTEGER"  enable="1" />
-- Retrieval info:      <PRIVATE name = "m144k" value="0"  type="INTEGER"  enable="1" />
-- Retrieval info:      <PRIVATE name = "m9k" value="0"  type="INTEGER"  enable="1" />
-- Retrieval info:      <PRIVATE name = "m20k" value="0"  type="INTEGER"  enable="1" />
-- Retrieval info:      <PRIVATE name = "mlab" value="0"  type="INTEGER"  enable="1" />
-- Retrieval info:      <PRIVATE name = "megaram" value="0"  type="INTEGER"  enable="1" />
-- Retrieval info:      <PRIVATE name = "dsp_block" value="65"  type="INTEGER"  enable="1" />
-- Retrieval info:      <PRIVATE name = "input_clock_period" value="1"  type="INTEGER"  enable="1" />
-- Retrieval info:      <PRIVATE name = "output_clock_period" value="1"  type="INTEGER"  enable="1" />
-- Retrieval info:      <PRIVATE name = "throughput" value="1"  type="INTEGER"  enable="1" />
-- Retrieval info:      <PRIVATE name = "memory_units" value="0"  type="INTEGER"  enable="1" />
-- Retrieval info:     </NAMESPACE>
-- Retrieval info:     <NAMESPACE name = "simgen_enable">
-- Retrieval info:      <PRIVATE name = "matlab_enable" value="1"  type="BOOLEAN"  enable="1" />
-- Retrieval info:      <PRIVATE name = "testbench_enable" value="1"  type="BOOLEAN"  enable="1" />
-- Retrieval info:      <PRIVATE name = "testbench_simulation_clock_period" value="10.0"  type="STRING"  enable="1" />
-- Retrieval info:      <PRIVATE name = "language" value="VHDL"  type="STRING"  enable="1" />
-- Retrieval info:      <PRIVATE name = "enabled" value="1"  type="BOOLEAN"  enable="1" />
-- Retrieval info:     </NAMESPACE>
-- Retrieval info:     <NAMESPACE name = "simgen">
-- Retrieval info:      <PRIVATE name = "filename" value="fir.vho"  type="STRING"  enable="1" />
-- Retrieval info:     </NAMESPACE>
-- Retrieval info:     <NAMESPACE name = "quartus_settings">
-- Retrieval info:      <PRIVATE name = "DEVICE" value="EP2C35F672C6"  type="STRING"  enable="1" />
-- Retrieval info:      <PRIVATE name = "FAMILY" value="Cyclone II"  type="STRING"  enable="1" />
-- Retrieval info:     </NAMESPACE>
-- Retrieval info:     <NAMESPACE name = "serializer"/>
-- Retrieval info:    </PRIVATES>
-- Retrieval info:    <FILES/>
-- Retrieval info:    <PORTS/>
-- Retrieval info:    <LIBRARIES/>
-- Retrieval info:   </STATIC_SECTION>
-- Retrieval info:  </NETLIST_SECTION>
-- Retrieval info: </MEGACORE>
-- =========================================================
-- RELATED_FILES: fir_st.v, fir_constraints.tcl, fir_ast.vhd, fir.vhd, fir_ast.vhd, fir.vhd;
-- IPFS_FILES: fir.vho;
-- =========================================================
