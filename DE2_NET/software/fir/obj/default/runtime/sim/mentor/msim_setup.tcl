
# (C) 2001-2023 Altera Corporation. All rights reserved.
# Your use of Altera Corporation's design tools, logic functions and 
# other software and tools, and its AMPP partner logic functions, and 
# any output files any of the foregoing (including device programming 
# or simulation files), and any associated documentation or information 
# are expressly subject to the terms and conditions of the Altera 
# Program License Subscription Agreement, Altera MegaCore Function 
# License Agreement, or other applicable license agreement, including, 
# without limitation, that your use is for the sole purpose of 
# programming logic devices manufactured by Altera and sold by Altera 
# or its authorized distributors. Please refer to the applicable 
# agreement for further details.

# ACDS 13.0sp1 232 win32 2023.06.27.23:58:28

# ----------------------------------------
# Auto-generated simulation script

# ----------------------------------------
# Initialize the variable
if ![info exists SYSTEM_INSTANCE_NAME] { 
  set SYSTEM_INSTANCE_NAME ""
} elseif { ![ string match "" $SYSTEM_INSTANCE_NAME ] } { 
  set SYSTEM_INSTANCE_NAME "/$SYSTEM_INSTANCE_NAME"
} 

if ![info exists TOP_LEVEL_NAME] { 
  set TOP_LEVEL_NAME "system_0_tb"
} 

if ![info exists QSYS_SIMDIR] { 
  set QSYS_SIMDIR "./../"
} 

if ![info exists QUARTUS_INSTALL_DIR] { 
  set QUARTUS_INSTALL_DIR "D:/altera/13.0sp1/quartus/"
} 


# ----------------------------------------
# Copy ROM/RAM files to simulation directory
alias file_copy {
  echo "\[exec\] file_copy"
  file copy -force C:/projeto/DE2_NET/system_0/testbench/system_0_tb/simulation/submodules/system_0_epcs_controller_boot_rom.hex ./
  file copy -force C:/projeto/DE2_NET/software/fir/mem_init/hdl_sim/cfi_flash_0.dat ./
  file copy -force C:/projeto/DE2_NET/software/fir/mem_init/hdl_sim/system_0_epcs_controller_boot_rom.dat ./
  file copy -force C:/projeto/DE2_NET/software/fir/mem_init/hdl_sim/sdram_0.dat ./
  file copy -force C:/projeto/DE2_NET/software/fir/mem_init/hdl_sim/system_0_epcs_controller_boot_rom.hex ./
}

# ----------------------------------------
# Create compilation libraries
proc ensure_lib { lib } { if ![file isdirectory $lib] { vlib $lib } }
ensure_lib          ./libraries/     
ensure_lib          ./libraries/work/
vmap       work     ./libraries/work/
vmap       work_lib ./libraries/work/
if { ![ string match "*ModelSim ALTERA*" [ vsim -version ] ] } {
  ensure_lib                  ./libraries/altera_ver/      
  vmap       altera_ver       ./libraries/altera_ver/      
  ensure_lib                  ./libraries/lpm_ver/         
  vmap       lpm_ver          ./libraries/lpm_ver/         
  ensure_lib                  ./libraries/sgate_ver/       
  vmap       sgate_ver        ./libraries/sgate_ver/       
  ensure_lib                  ./libraries/altera_mf_ver/   
  vmap       altera_mf_ver    ./libraries/altera_mf_ver/   
  ensure_lib                  ./libraries/altera_lnsim_ver/
  vmap       altera_lnsim_ver ./libraries/altera_lnsim_ver/
  ensure_lib                  ./libraries/cycloneii_ver/   
  vmap       cycloneii_ver    ./libraries/cycloneii_ver/   
  ensure_lib                  ./libraries/altera/          
  vmap       altera           ./libraries/altera/          
  ensure_lib                  ./libraries/lpm/             
  vmap       lpm              ./libraries/lpm/             
  ensure_lib                  ./libraries/sgate/           
  vmap       sgate            ./libraries/sgate/           
  ensure_lib                  ./libraries/altera_mf/       
  vmap       altera_mf        ./libraries/altera_mf/       
  ensure_lib                  ./libraries/altera_lnsim/    
  vmap       altera_lnsim     ./libraries/altera_lnsim/    
  ensure_lib                  ./libraries/cycloneii/       
  vmap       cycloneii        ./libraries/cycloneii/       
}
ensure_lib                                            ./libraries/SD_CLK/                                    
vmap       SD_CLK                                     ./libraries/SD_CLK/                                    
ensure_lib                                            ./libraries/SD_DAT/                                    
vmap       SD_DAT                                     ./libraries/SD_DAT/                                    
ensure_lib                                            ./libraries/switch_pio/                                
vmap       switch_pio                                 ./libraries/switch_pio/                                
ensure_lib                                            ./libraries/button_pio/                                
vmap       button_pio                                 ./libraries/button_pio/                                
ensure_lib                                            ./libraries/led_green/                                 
vmap       led_green                                  ./libraries/led_green/                                 
ensure_lib                                            ./libraries/led_red/                                   
vmap       led_red                                    ./libraries/led_red/                                   
ensure_lib                                            ./libraries/lcd_16207_0/                               
vmap       lcd_16207_0                                ./libraries/lcd_16207_0/                               
ensure_lib                                            ./libraries/timer_0/                                   
vmap       timer_0                                    ./libraries/timer_0/                                   
ensure_lib                                            ./libraries/uart_0/                                    
vmap       uart_0                                     ./libraries/uart_0/                                    
ensure_lib                                            ./libraries/jtag_uart_0/                               
vmap       jtag_uart_0                                ./libraries/jtag_uart_0/                               
ensure_lib                                            ./libraries/epcs_controller/                           
vmap       epcs_controller                            ./libraries/epcs_controller/                           
ensure_lib                                            ./libraries/sdram_0/                                   
vmap       sdram_0                                    ./libraries/sdram_0/                                   
ensure_lib                                            ./libraries/cfi_flash_0_external_mem_bfm/              
vmap       cfi_flash_0_external_mem_bfm               ./libraries/cfi_flash_0_external_mem_bfm/              
ensure_lib                                            ./libraries/tri_state_bridge_0_pinSharer_0_pin_divider/
vmap       tri_state_bridge_0_pinSharer_0_pin_divider ./libraries/tri_state_bridge_0_pinSharer_0_pin_divider/
ensure_lib                                            ./libraries/tri_state_bridge_0_bridge_0_tcb_translator/
vmap       tri_state_bridge_0_bridge_0_tcb_translator ./libraries/tri_state_bridge_0_bridge_0_tcb_translator/
ensure_lib                                            ./libraries/sdram_0_my_partner/                        
vmap       sdram_0_my_partner                         ./libraries/sdram_0_my_partner/                        
ensure_lib                                            ./libraries/system_0_inst_merged_resets_in_reset_bfm/  
vmap       system_0_inst_merged_resets_in_reset_bfm   ./libraries/system_0_inst_merged_resets_in_reset_bfm/  
ensure_lib                                            ./libraries/system_0_inst_clk_50_clk_in_bfm/           
vmap       system_0_inst_clk_50_clk_in_bfm            ./libraries/system_0_inst_clk_50_clk_in_bfm/           
ensure_lib                                            ./libraries/system_0_inst/                             
vmap       system_0_inst                              ./libraries/system_0_inst/                             

# ----------------------------------------
# Compile device library files
alias dev_com {
  echo "\[exec\] dev_com"
  if { ![ string match "*ModelSim ALTERA*" [ vsim -version ] ] } {
    vlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_primitives.v"              -work altera_ver      
    vlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/220model.v"                       -work lpm_ver         
    vlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/sgate.v"                          -work sgate_ver       
    vlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_mf.v"                      -work altera_mf_ver   
    vlog -sv "$QUARTUS_INSTALL_DIR/eda/sim_lib/mentor/altera_lnsim_for_vhdl.sv"  -work altera_lnsim_ver
    vlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/cycloneii_atoms.v"                -work cycloneii_ver   
    vcom     "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_syn_attributes.vhd"        -work altera          
    vcom     "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_standard_functions.vhd"    -work altera          
    vcom     "$QUARTUS_INSTALL_DIR/eda/sim_lib/alt_dspbuilder_package.vhd"       -work altera          
    vcom     "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_europa_support_lib.vhd"    -work altera          
    vcom     "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_primitives_components.vhd" -work altera          
    vcom     "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_primitives.vhd"            -work altera          
    vcom     "$QUARTUS_INSTALL_DIR/eda/sim_lib/220pack.vhd"                      -work lpm             
    vcom     "$QUARTUS_INSTALL_DIR/eda/sim_lib/220model.vhd"                     -work lpm             
    vcom     "$QUARTUS_INSTALL_DIR/eda/sim_lib/sgate_pack.vhd"                   -work sgate           
    vcom     "$QUARTUS_INSTALL_DIR/eda/sim_lib/sgate.vhd"                        -work sgate           
    vcom     "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_mf_components.vhd"         -work altera_mf       
    vcom     "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_mf.vhd"                    -work altera_mf       
    vcom     "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_lnsim_components.vhd"      -work altera_lnsim    
    vcom     "$QUARTUS_INSTALL_DIR/eda/sim_lib/cycloneii_atoms.vhd"              -work cycloneii       
    vcom     "$QUARTUS_INSTALL_DIR/eda/sim_lib/cycloneii_components.vhd"         -work cycloneii       
  }
}

# ----------------------------------------
# Compile the design files in correct order
alias com {
  echo "\[exec\] com"
  vcom     "C:/projeto/DE2_NET/system_0/testbench/system_0_tb/simulation/submodules/system_0_SD_CLK.vhd"                                                            -work SD_CLK                                    
  vcom     "C:/projeto/DE2_NET/system_0/testbench/system_0_tb/simulation/submodules/system_0_SD_DAT.vhd"                                                            -work SD_DAT                                    
  vcom     "C:/projeto/DE2_NET/system_0/testbench/system_0_tb/simulation/submodules/system_0_switch_pio.vhd"                                                        -work switch_pio                                
  vcom     "C:/projeto/DE2_NET/system_0/testbench/system_0_tb/simulation/submodules/system_0_button_pio.vhd"                                                        -work button_pio                                
  vcom     "C:/projeto/DE2_NET/system_0/testbench/system_0_tb/simulation/submodules/system_0_led_green.vhd"                                                         -work led_green                                 
  vcom     "C:/projeto/DE2_NET/system_0/testbench/system_0_tb/simulation/submodules/system_0_led_red.vhd"                                                           -work led_red                                   
  vcom     "C:/projeto/DE2_NET/system_0/testbench/system_0_tb/simulation/submodules/system_0_lcd_16207_0.vhd"                                                       -work lcd_16207_0                               
  vcom     "C:/projeto/DE2_NET/system_0/testbench/system_0_tb/simulation/submodules/system_0_timer_0.vhd"                                                           -work timer_0                                   
  vcom     "C:/projeto/DE2_NET/system_0/testbench/system_0_tb/simulation/submodules/system_0_uart_0.vhd"                                                            -work uart_0                                    
  vcom     "C:/projeto/DE2_NET/system_0/testbench/system_0_tb/simulation/submodules/system_0_jtag_uart_0.vhd"                                                       -work jtag_uart_0                               
  vcom     "C:/projeto/DE2_NET/system_0/testbench/system_0_tb/simulation/submodules/system_0_epcs_controller.vhd"                                                   -work epcs_controller                           
  vcom     "C:/projeto/DE2_NET/system_0/testbench/system_0_tb/simulation/submodules/system_0_sdram_0.vhd"                                                           -work sdram_0                                   
  vcom     "C:/projeto/DE2_NET/system_0/testbench/system_0_tb/simulation/submodules/system_0_sdram_0_test_component.vhd"                                            -work sdram_0                                   
  vlog -sv "C:/projeto/DE2_NET/system_0/testbench/system_0_tb/simulation/submodules/mentor/altera_external_memory_bfm.sv"                                           -work cfi_flash_0_external_mem_bfm              
  vlog -sv "C:/projeto/DE2_NET/system_0/testbench/system_0_tb/simulation/submodules/mentor/altera_external_memory_bfm_vhdl_wrapper.sv"                              -work cfi_flash_0_external_mem_bfm              
  vcom     "C:/projeto/DE2_NET/system_0/testbench/system_0_tb/simulation/submodules/altera_external_memory_bfm_vhdl_pkg.vhd"                                        -work cfi_flash_0_external_mem_bfm              
  vcom     "C:/projeto/DE2_NET/system_0/testbench/system_0_tb/simulation/submodules/altera_external_memory_bfm_vhdl.vhd"                                            -work cfi_flash_0_external_mem_bfm              
  vcom     "C:/projeto/DE2_NET/system_0/testbench/system_0_tb/simulation/submodules/altera_inout.vhd"                                                               -work tri_state_bridge_0_pinSharer_0_pin_divider
  vcom     "C:/projeto/DE2_NET/system_0/testbench/system_0_tb/simulation/submodules/altera_conduit_pin_divider.vhd"                                                 -work tri_state_bridge_0_pinSharer_0_pin_divider
  vcom     "C:/projeto/DE2_NET/system_0/testbench/system_0_tb/simulation/submodules/altera_inout.vhd"                                                               -work tri_state_bridge_0_bridge_0_tcb_translator
  vcom     "C:/projeto/DE2_NET/system_0/testbench/system_0_tb/simulation/submodules/altera_tristate_conduit_bridge_translator.vhd"                                  -work tri_state_bridge_0_bridge_0_tcb_translator
  vcom     "C:/projeto/DE2_NET/system_0/testbench/system_0_tb/simulation/submodules/altera_sdram_partner_module.vhd"                                                -work sdram_0_my_partner                        
  vcom     "C:/projeto/DE2_NET/system_0/testbench/system_0_tb/simulation/submodules/altera_avalon_reset_source.vhd"                                                 -work system_0_inst_merged_resets_in_reset_bfm  
  vcom     "C:/projeto/DE2_NET/system_0/testbench/system_0_tb/simulation/submodules/altera_avalon_clock_source.vhd"                                                 -work system_0_inst_clk_50_clk_in_bfm           
  vcom     "C:/projeto/DE2_NET/system_0/testbench/system_0_tb/simulation/submodules/system_0.vhd"                                                                   -work system_0_inst                             
  vcom     "C:/projeto/DE2_NET/system_0/testbench/system_0_tb/simulation/submodules/system_0_width_adapter.vhd"                                                     -work system_0_inst                             
  vcom     "C:/projeto/DE2_NET/system_0/testbench/system_0_tb/simulation/submodules/system_0_width_adapter_001.vhd"                                                 -work system_0_inst                             
  vcom     "C:/projeto/DE2_NET/system_0/testbench/system_0_tb/simulation/submodules/system_0_width_adapter_002.vhd"                                                 -work system_0_inst                             
  vcom     "C:/projeto/DE2_NET/system_0/testbench/system_0_tb/simulation/submodules/system_0_width_adapter_003.vhd"                                                 -work system_0_inst                             
  vcom     "C:/projeto/DE2_NET/system_0/testbench/system_0_tb/simulation/submodules/system_0_burst_adapter.vhd"                                                     -work system_0_inst                             
  vcom     "C:/projeto/DE2_NET/system_0/testbench/system_0_tb/simulation/submodules/system_0_burst_adapter_001.vhd"                                                 -work system_0_inst                             
  vcom     "C:/projeto/DE2_NET/system_0/testbench/system_0_tb/simulation/submodules/system_0_rst_controller.vhd"                                                    -work system_0_inst                             
  vcom     "C:/projeto/DE2_NET/system_0/testbench/system_0_tb/simulation/submodules/system_0_rst_controller_002.vhd"                                                -work system_0_inst                             
  vcom     "C:/projeto/DE2_NET/system_0/testbench/system_0_tb/simulation/submodules/system_0_cpu_0_jtag_debug_module_translator_avalon_universal_slave_0_agent.vhd" -work system_0_inst                             
  vcom     "C:/projeto/DE2_NET/system_0/testbench/system_0_tb/simulation/submodules/system_0_sdram_0_s1_translator_avalon_universal_slave_0_agent.vhd"              -work system_0_inst                             
  vcom     "C:/projeto/DE2_NET/system_0/testbench/system_0_tb/simulation/submodules/system_0_cfi_flash_0_uas_translator_avalon_universal_slave_0_agent.vhd"         -work system_0_inst                             
  vcom     "C:/projeto/DE2_NET/system_0/testbench/system_0_tb/simulation/submodules/system_0_cpu_0_instruction_master_translator.vhd"                               -work system_0_inst                             
  vcom     "C:/projeto/DE2_NET/system_0/testbench/system_0_tb/simulation/submodules/system_0_cpu_0_data_master_translator.vhd"                                      -work system_0_inst                             
  vcom     "C:/projeto/DE2_NET/system_0/testbench/system_0_tb/simulation/submodules/system_0_cpu_0_jtag_debug_module_translator.vhd"                                -work system_0_inst                             
  vcom     "C:/projeto/DE2_NET/system_0/testbench/system_0_tb/simulation/submodules/system_0_sdram_0_s1_translator.vhd"                                             -work system_0_inst                             
  vcom     "C:/projeto/DE2_NET/system_0/testbench/system_0_tb/simulation/submodules/system_0_epcs_controller_epcs_control_port_translator.vhd"                      -work system_0_inst                             
  vcom     "C:/projeto/DE2_NET/system_0/testbench/system_0_tb/simulation/submodules/system_0_cfi_flash_0_uas_translator.vhd"                                        -work system_0_inst                             
  vcom     "C:/projeto/DE2_NET/system_0/testbench/system_0_tb/simulation/submodules/system_0_sysid_qsys_0_control_slave_translator.vhd"                             -work system_0_inst                             
  vcom     "C:/projeto/DE2_NET/system_0/testbench/system_0_tb/simulation/submodules/system_0_jtag_uart_0_avalon_jtag_slave_translator.vhd"                          -work system_0_inst                             
  vcom     "C:/projeto/DE2_NET/system_0/testbench/system_0_tb/simulation/submodules/system_0_uart_0_s1_translator.vhd"                                              -work system_0_inst                             
  vcom     "C:/projeto/DE2_NET/system_0/testbench/system_0_tb/simulation/submodules/system_0_timer_0_s1_translator.vhd"                                             -work system_0_inst                             
  vcom     "C:/projeto/DE2_NET/system_0/testbench/system_0_tb/simulation/submodules/system_0_lcd_16207_0_control_slave_translator.vhd"                              -work system_0_inst                             
  vcom     "C:/projeto/DE2_NET/system_0/testbench/system_0_tb/simulation/submodules/system_0_led_red_s1_translator.vhd"                                             -work system_0_inst                             
  vcom     "C:/projeto/DE2_NET/system_0/testbench/system_0_tb/simulation/submodules/system_0_switch_pio_s1_translator.vhd"                                          -work system_0_inst                             
  vcom     "C:/projeto/DE2_NET/system_0/testbench/system_0_tb/simulation/submodules/system_0_isp1362_hc_translator.vhd"                                             -work system_0_inst                             
  vcom     "C:/projeto/DE2_NET/system_0/testbench/system_0_tb/simulation/submodules/system_0_audio_0_avalon_slave_0_translator.vhd"                                 -work system_0_inst                             
  vcom     "C:/projeto/DE2_NET/system_0/testbench/system_0_tb/simulation/submodules/system_0_vga_0_avalon_slave_0_translator.vhd"                                   -work system_0_inst                             
  vcom     "C:/projeto/DE2_NET/system_0/testbench/system_0_tb/simulation/submodules/system_0_seg7_display_avalon_slave_0_translator.vhd"                            -work system_0_inst                             
  vcom     "C:/projeto/DE2_NET/system_0/testbench/system_0_tb/simulation/submodules/system_0_pwm_0_avalon_slave_0_translator.vhd"                                   -work system_0_inst                             
  vcom     "C:/projeto/DE2_NET/system_0/testbench/system_0_tb/simulation/system_0_tb.vhd"                                                                                                                           
}

# ----------------------------------------
# Elaborate top level design
alias elab {
  echo "\[exec\] elab"
  vsim -t ps \
    -G/$TOP_LEVEL_NAME$SYSTEM_INSTANCE_NAME/sdram_0_my_partner/INIT_FILE=\"sdram_0.dat\" \
    -G/$TOP_LEVEL_NAME$SYSTEM_INSTANCE_NAME/system_0_inst/epcs_controller/INIT_FILE=\"system_0_epcs_controller_boot_rom.hex\" \
    -G/$TOP_LEVEL_NAME$SYSTEM_INSTANCE_NAME/cfi_flash_0_external_mem_bfm/INIT_FILE=\"cfi_flash_0.dat\" \
     -L work -L work_lib -L SD_CLK -L SD_DAT -L switch_pio -L button_pio -L led_green -L led_red -L lcd_16207_0 -L timer_0 -L uart_0 -L jtag_uart_0 -L epcs_controller -L sdram_0 -L cfi_flash_0_external_mem_bfm -L tri_state_bridge_0_pinSharer_0_pin_divider -L tri_state_bridge_0_bridge_0_tcb_translator -L sdram_0_my_partner -L system_0_inst_merged_resets_in_reset_bfm -L system_0_inst_clk_50_clk_in_bfm -L system_0_inst -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneii_ver -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cycloneii $TOP_LEVEL_NAME
}

# ----------------------------------------
# Elaborate the top level design with novopt option
alias elab_debug {
  echo "\[exec\] elab_debug"
  vsim -novopt -t ps \
    -G/$TOP_LEVEL_NAME$SYSTEM_INSTANCE_NAME/sdram_0_my_partner/INIT_FILE=\"sdram_0.dat\" \
    -G/$TOP_LEVEL_NAME$SYSTEM_INSTANCE_NAME/system_0_inst/epcs_controller/INIT_FILE=\"system_0_epcs_controller_boot_rom.hex\" \
    -G/$TOP_LEVEL_NAME$SYSTEM_INSTANCE_NAME/cfi_flash_0_external_mem_bfm/INIT_FILE=\"cfi_flash_0.dat\" \
     -L work -L work_lib -L SD_CLK -L SD_DAT -L switch_pio -L button_pio -L led_green -L led_red -L lcd_16207_0 -L timer_0 -L uart_0 -L jtag_uart_0 -L epcs_controller -L sdram_0 -L cfi_flash_0_external_mem_bfm -L tri_state_bridge_0_pinSharer_0_pin_divider -L tri_state_bridge_0_bridge_0_tcb_translator -L sdram_0_my_partner -L system_0_inst_merged_resets_in_reset_bfm -L system_0_inst_clk_50_clk_in_bfm -L system_0_inst -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneii_ver -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cycloneii $TOP_LEVEL_NAME
}

# ----------------------------------------
# Compile all the design files and elaborate the top level design
alias ld "
  dev_com
  com
  elab
"

# ----------------------------------------
# Compile all the design files and elaborate the top level design with -novopt
alias ld_debug "
  dev_com
  com
  elab_debug
"

# ----------------------------------------
# Print out user commmand line aliases
alias h {
  echo "List Of Command Line Aliases"
  echo
  echo "file_copy                     -- Copy ROM/RAM files to simulation directory"
  echo
  echo "dev_com                       -- Compile device library files"
  echo
  echo "com                           -- Compile the design files in correct order"
  echo
  echo "elab                          -- Elaborate top level design"
  echo
  echo "elab_debug                    -- Elaborate the top level design with novopt option"
  echo
  echo "ld                            -- Compile all the design files and elaborate the top level design"
  echo
  echo "ld_debug                      -- Compile all the design files and elaborate the top level design with -novopt"
  echo
  echo 
  echo
  echo "List Of Variables"
  echo
  echo "TOP_LEVEL_NAME                -- Top level module name."
  echo
  echo "SYSTEM_INSTANCE_NAME          -- Instantiated system module name inside top level module."
  echo
  echo "QSYS_SIMDIR                   -- Qsys base simulation directory."
  echo
  echo "QUARTUS_INSTALL_DIR           -- Quartus installation directory."
}
file_copy
h
