#!/bin/bash
rstroot=100ns.rst_
prmfile=../common/2agy_final_min.prmtop
inpfile=100ns-production
for i in {97..100}
do
    rstfile=$rstroot"$i"ns
    if [ -e $rstfile ]
    then
        dir="$i"ns 
        mkdir  $dir 
        
        cp submit.sh $dir
        cp $inpfile.in $dir    
        cp $rstfile $dir
        cp $prmfile $dir
        cd $dir
        echo `pwd`
        qsub -v RESTART=$rstfile,INPUT=$inpfile -N 100ns-$dir submit.sh 
        cd ../ 
     fi
done
