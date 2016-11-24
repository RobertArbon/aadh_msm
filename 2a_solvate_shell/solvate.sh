#!/bin/bash

# See http://www.mpibpc.mpg.de/274913/04-Command_line_options_and_parameters

filename=2agy_c36_state0_min
output=water_shell
solvate -t 12.0 -r 100.0 -n 10 -s -w $filename $output 
