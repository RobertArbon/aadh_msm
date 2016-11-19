#!/bin/bash
#PBS -l walltime=250:00:00
#PBS -l nodes=1:ppn=1 
#PBS -j oe
#PBS -N Minimization 
cd $PBS_O_WORKDIR
echo Running on host `hostname`
echo Time is `date`
echo Directory is `pwd`
echo PBS job ID is $PBS_JOBID
echo This jobs runs on the following machines:
echo `cat $PBS_NODEFILE | uniq`
input=minimize
charmm -i $input.inp > $input.out
