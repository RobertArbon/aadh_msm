#!/bin/bash
#PBS -N copy_data
#PBS -j oe
#PBS -l nodes=1:ppn=1,walltime=10:00:00


cd $PBS_O_WORKDIR 
rsync -rva round_2 $rdsf_dir/AADH/
