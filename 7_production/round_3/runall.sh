#!/bin/bash

ntraj=4
fileroot=2agy-310k-1atm-prod
filesdir=$rdsf_dir/AADH/round_2
rootdir=`pwd`
subscript=submit.sh

for i in `seq 2 10`;
do
	for j in `seq 1 1`;
    do 
		# Create folder
		newdir=prod-$i.$j.1
		mkdir -p $newdir

        # Move into folder
        cd $newdir

        # Copy submit,GPU and initial res/cor files
		input=$fileroot$i.$j.1
		output=$fileroot$i.$j.2
		cp $filesdir/prod-$i/prod-$i.$j/$fileroot$i.$j.cor $input.cor 
		cp $filesdir/prod-$i/prod-$i.$j/$fileroot$i.$j.res $input.res
        cp $rootdir/$subscript .
		cp $rootdir/get_X_GPUs.sh .
        cp $rootdir/production.inp .
 
		# Run first job
        job=`qsub -v INPUT=$input,OUTPUT=$output -N $input $subscript`

		# Run dependent jobs
		for k in `seq 2 $ntraj`;
 		do
		  input=$fileroot$i.$j.$k
		  newk=$((k+1))
		  output=$fileroot$i.$j.$newk
          
		  job_next=`qsub -W depend=afterok:$job -v INPUT=$input,OUTPUT=$output -N $input $subscript`
          job=$job_next	
   		done

		cd $rootdir
	done
done



