#!/bin/bash

charmm_dir=/users/robert_arbon/Code/c41a2/exec/gnu

declare -a pass_conditions

pass_conditions=(
"                    NORMAL TERMINATION BY NORMAL STOP"
"      ***** LEVEL -5 WARNING FROM <MORSE> *****"
"      ***** LEVEL -5 WARNING FROM <MORSE> *****"
"      ***** LEVEL -5 WARNING FROM <MORSE> *****"
"      ***** LEVEL -5 WARNING FROM <MORSE> *****"
"                    NORMAL TERMINATION BY NORMAL STOP"
"      ***** LEVEL -5 WARNING FROM <MORSE> *****"
"      ***** LEVEL -5 WARNING FROM <MORSE> *****"
"                    NORMAL TERMINATION BY NORMAL STOP"
"      ***** LEVEL -5 WARNING FROM <MORSE> *****"
"      ***** LEVEL -5 WARNING FROM <MORSE> *****"
"                    NORMAL TERMINATION BY NORMAL STOP"
"                    NORMAL TERMINATION BY NORMAL STOP"
"                    NORMAL TERMINATION BY NORMAL STOP"
"                    NORMAL TERMINATION BY NORMAL STOP"
"                    NORMAL TERMINATION BY NORMAL STOP"
"'TEST PASSED'"
"'TEST PASSED'"
"'TEST PASSED'"
"'TEST PASSED'"
"'TEST PASSED'"
"'TEST PASSED'"
"'TEST PASSED'"
"'TEST PASSED'"
"'TEST PASSED'"
"'TEST PASSED'"
)

num_tests=${#pass_conditions[@]}
for jobnum in $(seq 1 $num_tests);
do
    $charmm_dir/charmm -i ./tests/$jobnum.inp > ./tests_output/$jobnum.out
    if grep -Fxq "${pass_conditions[$jobnum-1]}" ./tests_output/$jobnum.out
    then
        echo 'PASS - ' "$jobnum"
    else
        echo 'FAIL - ' "$jobnum"
    fi
done
