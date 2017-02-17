#!/bin/bash
#PBS -N Test_all
#PBS -j oe
#PBS -l nodes=1:ppn=1,walltime=01:00:00
#PBS -m a

cd $PBS_O_WORKDIR
echo `pwd`
qsub submit.sh 



