#!/bin/bash

charmm_dir=/users/robert_arbon/code/c41a2/exec/original/gnu
input=neutralize

$charmm_dir/charmm -i $input.inp > $input.out
