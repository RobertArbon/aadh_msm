#!/bin/bash

kstart=1
kend=9
fileroot=2agy-310k-1atm-prod
filesdir=$rdsf_dir/AADH/round_2
rootdir=`pwd`
subscript=submit.sh

for i in `seq 1 10`;
do
	for j in `seq 2 2`;
    do 
		# Create folder
		# Enforce new naming convention
		newdir=prod-$i.$j
		mkdir -p $newdir

        # Move into folder
        cd $newdir

        # Copy submit,GPU and initial res/cor files
		# enforce new naming convention
		input=$fileroot$i.$j-$kstart
		output=$fileroot$i.$j-$((kstart+1))

		cp $filesdir/prod-$i/prod-$i.$j/$fileroot$i.$j.cor $input.cor 
		cp $filesdir/prod-$i/prod-$i.$j/$fileroot$i.$j.res $input.res
        cp $rootdir/$subscript .
		cp $rootdir/get_X_GPUs.sh .
        cp $rootdir/production.inp .
 
		# Run first job
        job=`qsub -v INPUT=$input,OUTPUT=$output -N $input $subscript`

		# Run dependent jobs
		for k in `seq $((kstart+1)) $kend`;
 		do
		  input=$fileroot$i.$j-$k
		  newk=$((k+1))
		  output=$fileroot$i.$j-$newk
          
		  job_next=`qsub -W depend=afterok:$job -v INPUT=$input,OUTPUT=$output -N $input $subscript`
          job=$job_next	
   		done

		cd $rootdir
	done
done



