#!/bin/bash

for jobnum in $(seq 1 9);
do 
	cp gamma.inp gamma.0.$jobnum.inp
    sed -i "42s/.*/calc gamma $jobnum * 0.1 /" gamma.0.$jobnum.inp
    sed -i "13s/.*/input=gamma.0.$jobnum/" gamma.sh
	qsub gamma.sh
done
for jobnum in $(seq 1 10);
do 
	cp gamma.inp gamma.$jobnum.inp
    sed -i "42s/.*/calc gamma $jobnum * 1 /" gamma.$jobnum.inp
    sed -i "13s/.*/input=gamma.$jobnum/" gamma.sh
	qsub gamma.sh
done
 

 

