###############################################################################
# Created by write_sdc
# Sun Nov 19 04:41:05 2023
###############################################################################
current_design ADC_Flash_Logic
###############################################################################
# Timing Constraints
###############################################################################
create_clock -name clk -period 24.0000 
set_clock_uncertainty 0.2500 clk
set_clock_latency -source -min 4.6500 [get_clocks {clk}]
set_clock_latency -source -max 5.5700 [get_clocks {clk}]
###############################################################################
# Environment
###############################################################################
set_load -pin_load 0.1900 [get_ports {eoc}]
set_load -pin_load 0.1900 [get_ports {B[9]}]
set_load -pin_load 0.1900 [get_ports {B[8]}]
set_load -pin_load 0.1900 [get_ports {B[7]}]
set_load -pin_load 0.1900 [get_ports {B[6]}]
set_load -pin_load 0.1900 [get_ports {B[5]}]
set_load -pin_load 0.1900 [get_ports {B[4]}]
set_load -pin_load 0.1900 [get_ports {B[3]}]
set_load -pin_load 0.1900 [get_ports {B[2]}]
set_load -pin_load 0.1900 [get_ports {B[1]}]
set_load -pin_load 0.1900 [get_ports {B[0]}]
set_load -pin_load 0.1900 [get_ports {BN[9]}]
set_load -pin_load 0.1900 [get_ports {BN[8]}]
set_load -pin_load 0.1900 [get_ports {BN[7]}]
set_load -pin_load 0.1900 [get_ports {BN[6]}]
set_load -pin_load 0.1900 [get_ports {BN[5]}]
set_load -pin_load 0.1900 [get_ports {BN[4]}]
set_load -pin_load 0.1900 [get_ports {BN[3]}]
set_load -pin_load 0.1900 [get_ports {BN[2]}]
set_load -pin_load 0.1900 [get_ports {BN[1]}]
set_load -pin_load 0.1900 [get_ports {BN[0]}]
set_timing_derate -early 0.9500
set_timing_derate -late 1.0500
###############################################################################
# Design Rules
###############################################################################
set_max_transition 1.0000 [current_design]
set_max_fanout 16.0000 [current_design]
