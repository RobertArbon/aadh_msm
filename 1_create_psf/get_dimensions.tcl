### Script to get the dimensions of the solvated 2agy simulation performed by KR
###

# set tcl_precision 8

set molname 2agy_sol_ion

mol new ${molname}.psf
mol addfile ${molname}.pdb

set everyone [atomselect top all]
set protonly [atomselect top protein] 

set cen1 [measure center $everyone weight mass]
set x1 [lindex $cen1 0]
set y1 [lindex $cen1 1]
set z1 [lindex $cen1 2]

set cen2 [measure center $protonly weight mass]
set x2 [lindex $cen2 0]
set y2 [lindex $cen2 1]
set z2 [lindex $cen2 2]

set cen3 [measure center $everyone]
set x3 [lindex $cen3 0]
set y3 [lindex $cen3 1]
set z3 [lindex $cen3 2]

# set cen [measure center [atomselect top protein]]
# set x2 [lindex $cen 0]
# set y2 [lindex $cen 1]
# set z2 [lindex $cen 2]

# put "Centre of protein = ($x2,$y2,$z2)"

set dims [measure minmax $everyone]
set xmin [lindex [lindex $dims 0] 0]
set ymin [lindex [lindex $dims 0] 1]
set zmin [lindex [lindex $dims 0] 2]

set xmax [lindex [lindex $dims 1] 0]
set ymax [lindex [lindex $dims 1] 1]
set zmax [lindex [lindex $dims 1] 2]

put "x length: [expr $xmax - $xmin] A"
put "y length: [expr $ymax - $ymin] A"
put "z length: [expr $zmax - $zmin] A"
put ""
put "Centre of simulation =         ($x3,$y3,$z3)"
put ""
put "Centre-of-mass of simulation = ($x1,$y1,$z1)"
put ""
put "Centre-of-mass of protein =    ($x2,$y2,$z2)"

set minmax [measure minmax $protonly]

# set max 0
# foreach atom [$protonly get index] {
#   set pos [lindex [[atomselect top "index $atom"] get {x y z}] 0]
#   set x4 [lindex $pos 0]
#   set y4 [lindex $pos 1]
#   set z4 [lindex $pos 2]
#   set dist [expr pow(($x4-$x2)*($x4-$x2) + ($y4-$y2)*($y4-$y2) + ($z4-$z2)*($z4-$z2),0.5)]
#   # put $dist
#   if {$dist > $max} {set max $dist}
#   }

put ""
put "Extent of protein =  $minmax A"

