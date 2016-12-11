#!/bin/bash
for i in {1..8} 
do
    cp wt$i.pdb bkup_wt$i.pdb
    sed -i -e 's/TIP3W/TIP3 /g' wt$i.pdb 
done

