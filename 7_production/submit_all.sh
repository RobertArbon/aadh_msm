#!/bin/bash
fileroot=2agy-310k-1atm

for i in {1..10}
do
    mkdir -p prod-$i
    cd prod-$i
    cp ../$fileroot-prod$i.{cor,res} .
    for j in {1..10}
    do 
        mkdir prod-$i.$j
        cd prod-$i.$j
        prodfile=production$i.$j.inp
        cp ../../production.inp $prodfile
        cp ../../submit.sh . 
        cp ../../get_X_GPUs.sh .

        # Adjust input script
        sed -i "s/set rand1/set rand1 $RANDOM/" $prodfile
        sed -i "s/set rand2/set rand2 $RANDOM/" $prodfile
        sed -i "s/set rand3/set rand3 $RANDOM/" $prodfile
        sed -i "s/set rand4/set rand4 $RANDOM/" $prodfile
        sed -i "s/set prodid/set prodid $i.$j/" $prodfile
        sed -i "s/set input .*/set input ..\/$fileroot-prod$i/" $prodfile
        sed -i "s/set output .*/set output $fileroot-prod$i.$j/" $prodfile
        
        # Adjust submit script
        sed -i -e "s/input=production[0-9]/input=production$i.$j/" submit.sh
        sed -i -e "s/\#PBS -N production[0-9]*/\#PBS -N production$i.$j/" submit.sh
        qsub submit.sh
        cd ../
    done
    cd ../
done
