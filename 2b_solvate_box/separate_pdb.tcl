#Create a different PDB for each chain of the protein:
set molname ionized 
mol new ${molname}.psf
mol addfile ${molname}.pdb

for {set i 1} {$i < 13} {incr i} {
	set seg [atomselect top [format "segname WT%d" $i]] 
	$seg writepdb [format "wt%d.pdb" $i] 
}	
	set seg [atomselect top "segname ION" ] 
	$seg writepdb "ion.pdb"  

