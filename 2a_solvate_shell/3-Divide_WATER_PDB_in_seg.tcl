#Create a different PDB for each chain of the protein:
	set seg [atomselect top "segname W100 to W104"]
	$seg set segname WAT1
	$seg writepdb WAT1.pdb
	$seg delete
	
	set seg [atomselect top "segname W105"]
	$seg set segname WAT2
	$seg writepdb WAT2.pdb
	$seg delete

	set seg [atomselect top "segname W106"]
	$seg set segname WAT3
	$seg writepdb WAT3.pdb
	$seg delete


