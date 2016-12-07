#Create a different PDB for each chain of the protein:
	set seg [atomselect top "segname W100 to W128"]
	$seg set segname WAT1
	$seg writepdb WAT1.pdb
	$seg delete
	
	set seg [atomselect top "segname W129"]
	$seg set segname WAT2
	$seg writepdb WAT2.pdb
	$seg delete


