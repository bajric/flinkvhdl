# TCL File Generated by Component Editor 13.0sp1
# Mon Jan 19 07:37:04 CET 2015
# DO NOT MODIFY


# 
# ldc1000_block "LDC1000" v0.1
# NTB (www.ntb.ch) 2015.01.19.07:37:04
# Provides a flink subdevice for the LDC1000 inductance sensor
# 

# 
# request TCL package from ACDS 13.1
# 
package require -exact qsys 13.1


# 
# module ldc1000_block
# 
set_module_property DESCRIPTION "Provides a flink subdevice for the LDC1000 inductance sensor"
set_module_property NAME ldc1000_block
set_module_property VERSION 0.1
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property GROUP fLink
set_module_property AUTHOR "NTB (www.ntb.ch)"
set_module_property DISPLAY_NAME LDC1000
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property ANALYZE_HDL AUTO
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL avalon_ldc1000_interface
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
add_fileset_file avalon_ldc1000_interface.m.vhd VHDL PATH avalon_ldc1000_interface.m.vhd TOP_LEVEL_FILE
add_fileset_file flink_definitions.vhd VHDL PATH ../../../../fLink/core/flink_definitions.vhd


# 
# parameters
# 
add_parameter unice_id STD_LOGIC_VECTOR 0
set_parameter_property unice_id DEFAULT_VALUE 0
set_parameter_property unice_id DISPLAY_NAME unice_id
set_parameter_property unice_id TYPE STD_LOGIC_VECTOR
set_parameter_property unice_id UNITS None
set_parameter_property unice_id ALLOWED_RANGES 0:4294967295
set_parameter_property unice_id HDL_PARAMETER true


# 
# display items
# 


# 
# connection point clock_sink
# 
add_interface clock_sink clock end
set_interface_property clock_sink clockRate 0
set_interface_property clock_sink ENABLED true
set_interface_property clock_sink EXPORT_OF ""
set_interface_property clock_sink PORT_NAME_MAP ""
set_interface_property clock_sink SVD_ADDRESS_GROUP ""

add_interface_port clock_sink isl_clk clk Input 1


# 
# connection point reset_sink
# 
add_interface reset_sink reset end
set_interface_property reset_sink associatedClock clock_sink
set_interface_property reset_sink synchronousEdges DEASSERT
set_interface_property reset_sink ENABLED true
set_interface_property reset_sink EXPORT_OF ""
set_interface_property reset_sink PORT_NAME_MAP ""
set_interface_property reset_sink SVD_ADDRESS_GROUP ""

add_interface_port reset_sink isl_reset_n reset_n Input 1


# 
# connection point avalon_slave
# 
add_interface avalon_slave avalon end
set_interface_property avalon_slave addressUnits WORDS
set_interface_property avalon_slave associatedClock clock_sink
set_interface_property avalon_slave associatedReset reset_sink
set_interface_property avalon_slave bitsPerSymbol 8
set_interface_property avalon_slave burstOnBurstBoundariesOnly false
set_interface_property avalon_slave burstcountUnits WORDS
set_interface_property avalon_slave explicitAddressSpan 0
set_interface_property avalon_slave holdTime 0
set_interface_property avalon_slave linewrapBursts false
set_interface_property avalon_slave maximumPendingReadTransactions 0
set_interface_property avalon_slave readLatency 0
set_interface_property avalon_slave readWaitTime 1
set_interface_property avalon_slave setupTime 0
set_interface_property avalon_slave timingUnits Cycles
set_interface_property avalon_slave writeWaitTime 0
set_interface_property avalon_slave ENABLED true
set_interface_property avalon_slave EXPORT_OF ""
set_interface_property avalon_slave PORT_NAME_MAP ""
set_interface_property avalon_slave SVD_ADDRESS_GROUP ""

add_interface_port avalon_slave islv_avs_address address Input 8
add_interface_port avalon_slave isl_avs_read read Input 1
add_interface_port avalon_slave isl_avs_write write Input 1
add_interface_port avalon_slave osl_avs_waitrequest waitrequest Output 1
add_interface_port avalon_slave islv_avs_write_data writedata Input 32
add_interface_port avalon_slave oslv_avs_read_data readdata Output 32
set_interface_assignment avalon_slave embeddedsw.configuration.isFlash 0
set_interface_assignment avalon_slave embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment avalon_slave embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment avalon_slave embeddedsw.configuration.isPrintableDevice 0


# 
# connection point conduit_end
# 
add_interface conduit_end conduit end
set_interface_property conduit_end associatedClock clock_sink
set_interface_property conduit_end associatedReset reset_sink
set_interface_property conduit_end ENABLED true
set_interface_property conduit_end EXPORT_OF ""
set_interface_property conduit_end PORT_NAME_MAP ""
set_interface_property conduit_end SVD_ADDRESS_GROUP ""

add_interface_port conduit_end isl_cs export Input 1
add_interface_port conduit_end isl_sdi export Input 1
add_interface_port conduit_end isl_sdo export Output 1
add_interface_port conduit_end isl_sclk export Input 1
add_interface_port conduit_end isl_tbclk export Output 1

