-------------------------------------------------------------------------------
--     ____  _____          __    __    ________    _______
--    |    | \    \        |   \ |  |  |__    __|  |   __  \
--    |____|  \____\       |    \|  |     |  |     |  |__>  ) 
--     ____   ____         |  |\ \  |     |  |     |   __  <
--    |    | |    |        |  | \   |     |  |     |  |__>  )
--    |____| |____|        |__|  \__|     |__|     |_______/
--
--    NTB University of Applied Sciences in Technology
--
--    Campus Buchs - Werdenbergstrasse 4 - 9471 Buchs - Switzerland
--    Campus Waldau - Schoenauweg 4 - 9013 St. Gallen - Switzerland
--
--    Web http://www.ntb.ch        Tel. +41 81 755 33 11
--
-------------------------------------------------------------------------------
-- Copyright 2013 NTB University of Applied Sciences in Technology
-------------------------------------------------------------------------------
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
-- 
-- http://www.apache.org/licenses/LICENSE-2.0
--   
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
-------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.math_real.ALL;

USE work.fLink_definitions.ALL;

PACKAGE avalon_adcad7606_4_interface_pkg IS

	COMPONENT avalon_adcad7606_4_interface IS
			GENERIC (
				BASE_CLK: INTEGER := 33000000; 
				SCLK_FREQUENCY : INTEGER := 10000000;--Min 0.8 Mhz, max 16Mhz
				UNICE_ID: STD_LOGIC_VECTOR (c_fLink_avs_data_width-1 DOWNTO 0) := (OTHERS => '0')
			);
			PORT (
					isl_clk					: IN STD_LOGIC;
					isl_reset_n				: IN STD_LOGIC;
					
					islv_avs_address		: IN STD_LOGIC_VECTOR(c_analog_input_interface_address_with-1 DOWNTO 0);
					isl_avs_read			: IN STD_LOGIC;
					isl_avs_write			: IN STD_LOGIC;
					islv_avs_write_data		: IN STD_LOGIC_VECTOR(c_fLink_avs_data_width-1 DOWNTO 0);
					oslv_avs_read_data		: OUT STD_LOGIC_VECTOR(c_fLink_avs_data_width-1 DOWNTO 0);
					osl_avs_waitrequest		: OUT STD_LOGIC;
					
					osl_sclk				: OUT STD_LOGIC;
					oslv_Ss					: OUT STD_LOGIC;
					osl_mosi				: OUT STD_LOGIC;
					isl_miso				: IN STD_LOGIC;
					
					isl_d_out_b				: IN STD_LOGIC;
					oslv_conv_start			: OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
					osl_range				: OUT STD_LOGIC;
					oslv_os					: OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
					isl_busy				: IN STD_LOGIC; 
					isl_first_data			: IN STD_LOGIC;
					osl_adc_reset			: OUT STD_LOGIC;
					osl_stby_n				: OUT STD_LOGIC
					
					
			);
	END COMPONENT;

	CONSTANT c_adcad7606_4_subtype_id : INTEGER := 2;
	CONSTANT c_adcad7606_4_interface_version : INTEGER := 0;


END PACKAGE avalon_adcad7606_4_interface_pkg;

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.math_real.ALL;
USE work.avalon_adcad7606_4_interface_pkg.ALL;
USE work.fLink_definitions.ALL;
USE work.adcad7606_4_pkg.ALL;

ENTITY avalon_adcad7606_4_interface IS
			GENERIC (
				BASE_CLK: INTEGER := 33000000; 
				SCLK_FREQUENCY : INTEGER := 10000000;--Min 0.8 Mhz, max 16Mhz
				UNICE_ID: STD_LOGIC_VECTOR (c_fLink_avs_data_width-1 DOWNTO 0) := (OTHERS => '0')
			);
			PORT (
					isl_clk					: IN STD_LOGIC;
					isl_reset_n				: IN STD_LOGIC;
					
					islv_avs_address		: IN STD_LOGIC_VECTOR(c_analog_input_interface_address_with-1 DOWNTO 0);
					isl_avs_read			: IN STD_LOGIC;
					isl_avs_write			: IN STD_LOGIC;
					islv_avs_write_data		: IN STD_LOGIC_VECTOR(c_fLink_avs_data_width-1 DOWNTO 0);
					oslv_avs_read_data		: OUT STD_LOGIC_VECTOR(c_fLink_avs_data_width-1 DOWNTO 0);
					osl_avs_waitrequest		: OUT STD_LOGIC;
					
					osl_sclk				: OUT STD_LOGIC;
					oslv_Ss					: OUT STD_LOGIC;
					osl_mosi				: OUT STD_LOGIC;
					isl_miso				: IN STD_LOGIC;
					
					isl_d_out_b				: IN STD_LOGIC;
					oslv_conv_start			: OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
					osl_range				: OUT STD_LOGIC;
					oslv_os					: OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
					isl_busy				: IN STD_LOGIC; 
					isl_first_data			: IN STD_LOGIC;
					osl_adc_reset			: OUT STD_LOGIC;
					osl_stby_n				: OUT STD_LOGIC
					
					
			);

	CONSTANT c_usig_resolution_address: UNSIGNED(c_analog_input_interface_address_with-1 DOWNTO 0) := to_unsigned(c_fLink_number_of_std_registers,c_analog_input_interface_address_with);
	CONSTANT c_usig_value_0_address: UNSIGNED(c_analog_input_interface_address_with-1 DOWNTO 0) := c_usig_resolution_address + 1;
	CONSTANT c_usig_last_address: UNSIGNED(c_analog_input_interface_address_with-1 DOWNTO 0) := c_usig_value_0_address + NUMBER_OF_CHANELS;
	
	
END ENTITY avalon_adcad7606_4_interface;

ARCHITECTURE rtl OF avalon_adcad7606_4_interface IS

	TYPE t_internal_register IS RECORD
			global_reset_n		: STD_LOGIC;
			adc_reset_n			: STD_LOGIC;
			config				: t_config;
	END RECORD;

	SIGNAL ri,ri_next : t_internal_register;
	SIGNAL adc_values : t_value_regs;
	
BEGIN
	my_adcad7606_4 : adcad7606_4 
		GENERIC MAP (BASE_CLK,SCLK_FREQUENCY)
		PORT MAP (isl_clk,ri.adc_reset_n,adc_values,ri.config,osl_sclk,oslv_Ss,osl_mosi,isl_miso,isl_d_out_b,oslv_conv_start,osl_range,oslv_os,isl_busy,isl_first_data,osl_adc_reset,osl_stby_n);

		
	-- cobinatoric process
	comb_proc : PROCESS (isl_reset_n,ri,isl_avs_write,islv_avs_address,isl_avs_read,islv_avs_write_data,adc_values)
		VARIABLE vi :	t_internal_register;
		VARIABLE adcad7606_4_part_nr: INTEGER := 0;
	BEGIN
		-- keep variables stable
		vi := ri;	

		--standard values
		
		oslv_avs_read_data <= (OTHERS => '0');
		vi.global_reset_n := '1';
		vi.adc_reset_n := '1';
		vi.config.range_select := '0'; -- '0' range is +-5V
		vi.config.oversampling := (OTHERS => '0'); -- no oversampling
		vi.config.standby := '1';
		
		
		--avalon slave interface write part
		IF isl_avs_write = '1' THEN
			IF UNSIGNED(islv_avs_address) = to_unsigned(c_fLink_configuration_address,c_analog_input_interface_address_with) THEN
				vi.global_reset_n := NOT islv_avs_write_data(0);		
			END IF;
		END IF;

		--avalon slave interface read part
		IF isl_avs_read = '1' THEN
			CASE UNSIGNED(islv_avs_address) IS
				WHEN to_unsigned(c_fLink_typdef_address,c_analog_input_interface_address_with) =>
					oslv_avs_read_data ((c_fLink_interface_version_length + c_fLink_subtype_length + c_fLink_id_length - 1) DOWNTO 
												(c_fLink_interface_version_length + c_fLink_subtype_length)) <= STD_LOGIC_VECTOR(to_unsigned(c_fLink_analog_input_id,c_fLink_id_length));
					oslv_avs_read_data((c_fLink_interface_version_length + c_fLink_subtype_length - 1) DOWNTO c_fLink_interface_version_length) <= STD_LOGIC_VECTOR(to_unsigned(c_adcad7606_4_subtype_id,c_fLink_subtype_length));
					oslv_avs_read_data(c_fLink_interface_version_length-1 DOWNTO 0) <=  STD_LOGIC_VECTOR(to_unsigned(c_adcad7606_4_interface_version,c_fLink_interface_version_length));
				WHEN to_unsigned(c_fLink_mem_size_address,c_analog_input_interface_address_with) => 
					oslv_avs_read_data(c_analog_input_interface_address_with+2) <= '1';
				WHEN to_unsigned(c_fLink_number_of_chanels_address,c_analog_input_interface_address_with) => 
					oslv_avs_read_data <= std_logic_vector(to_unsigned(NUMBER_OF_CHANELS,c_fLink_avs_data_width));
				WHEN to_unsigned(c_fLink_unice_id_address,c_analog_input_interface_address_with) => 
					oslv_avs_read_data <= UNICE_ID;
				WHEN c_usig_resolution_address =>
					oslv_avs_read_data <= std_logic_vector(to_unsigned(RESOLUTION,c_fLink_avs_data_width));
				WHEN OTHERS => 
					IF UNSIGNED(islv_avs_address)>= c_usig_value_0_address AND UNSIGNED(islv_avs_address)< c_usig_last_address THEN
						adcad7606_4_part_nr := to_integer(UNSIGNED(islv_avs_address) - c_usig_value_0_address); 		
						oslv_avs_read_data(RESOLUTION-1 DOWNTO 0) <= std_logic_vector(adc_values(adcad7606_4_part_nr));
					END IF;
			END CASE;
		END IF;

		IF isl_reset_n = '0' OR vi.global_reset_n = '0'  THEN
			vi.adc_reset_n := '0';
		END IF;
		
		--keep variables stable
		ri_next <= vi;
	
	END PROCESS comb_proc;
	
	reg_proc : PROCESS (isl_clk)
	BEGIN
		IF rising_edge(isl_clk) THEN
			ri <= ri_next;
		END IF;
	END PROCESS reg_proc;

	osl_avs_waitrequest <= '0';

END rtl;









