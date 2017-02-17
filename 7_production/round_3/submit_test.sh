#!/bin/bash 
#PBS -j oe 
#PBS -l nodes=1:ppn=1,walltime=00:20:00
#PBS -m a

#! change the working directory (default is home directory)

cd $PBS_O_WORKDIR
echo Running on host `hostname`
echo Time is `date`
echo Directory is `pwd`
echo PBS job ID is $PBS_JOBID

#! Set up input file based on parameters passed to submit script
chmfile=random_fail

echo "Starting coords are $INPUT"
echo "Final coords are $OUTPUT"
sed -i "s/set input .*/set input $INPUT/" $chmfile.inp
sed -i "s/set output .*/set output $OUTPUT/" $chmfile.inp

#! Run the executable
count=1
flag=1
while [ "$flag" -ne 0 ]
do
    echo "Running script: attempt $count"
    charmm -i $chmfile.inp > $chmfile.out
    flag=$?
    echo "Exit status : $flag"
    count=$((count+1))
done
