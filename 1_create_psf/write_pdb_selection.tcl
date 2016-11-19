# Writes out the pdb for 2agy and x-water from 2agy_sol_ion.pdb
# so that a new pdb and psf can be made with the CHARMM36 forcefield
#

set molname 2agy_sol_ion

mol new ${molname}.psf
mol addfile ${molname}.pdb

set xw1 [atomselect top "segid XW1"]
set xw2 [atomselect top "segid XW2"]
set xw3 [atomselect top "segid XW3"]
set xw4 [atomselect top "segid XW4"]

$xw1 writepdb xw1.pdb
$xw2 writepdb xw2.pdb
$xw3 writepdb xw3.pdb
$xw4 writepdb xw4.pdb

set A [atomselect top "chain A"]
set B [atomselect top "chain B"]
set D [atomselect top "chain D"]
set H [atomselect top "chain H"]

$A writepdb A.pdb
$B writepdb B.pdb
$D writepdb D.pdb
$H writepdb H.pdb
