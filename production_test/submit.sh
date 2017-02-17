#!/bin/bash 
#PBS -N Test
#PBS -j oe 
#PBS -q gpu
#PBS -l nodes=1:ppn=1:gpus=1:exclusive_process,walltime=00:10:00
#PBS -m a

#! change the working directory (default is home directory)

cd $PBS_O_WORKDIR
echo Running on host `hostname`
echo Time is `date`
echo Directory is `pwd`
echo PBS job ID is $PBS_JOBID
echo This jobs runs on the following GPUs:
echo `cat $PBS_GPUFILE | uniq`

#From GPU file, export visible devices to GPUs
##export CUDA_VISIBLE_DEVICES=`cat $PBS_GPUFILE | awk -F"-gpu" '{ printf A$2;A=","}'`

#! Get GPUs
nvidia-smi
nvidia-smi -q -d COMPUTE
./get_X_GPUs.sh 1

rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi

#! Set up input file based on parameters passed to submit script
echo "Starting coords are $INPUT"
echo "Final coords are $OUTPUT"

#! Run the executable
count=1
flag=1
while [ "$flag" -ne 0 ]
do
    echo "Running script: attempt $count"
    charmm -i random_fail.inp > random_fail.out
    flag=$?
    echo "Exit status : $flag"
    count=$((count+1))
done
