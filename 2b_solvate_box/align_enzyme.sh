#!/bin/bash
#PBS -l walltime=00:10:00
#PBS -l nodes=1:ppn=1
#PBS -j oe
#PBS -N AADH_aligned
cd $PBS_O_WORKDIR
echo Running on host `hostname`
echo Time is `date`
echo Directory is `pwd`
echo PBS job ID is $PBS_JOBID
echo `cat $PBS_NODEFILE | uniq`
input=realign_enzyme
charmm -i $input.inp > $input.out
