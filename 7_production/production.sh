#!/bin/bash

for i in `seq 3 10`
do 
  cp production.inp production$i.inp
  sed -i "s/set rand1/set rand1 $RANDOM/" production$i.inp
  sed -i "s/set rand2/set rand2 $RANDOM/" production$i.inp
  sed -i "s/set rand3/set rand3 $RANDOM/" production$i.inp
  sed -i "s/set rand4/set rand4 $RANDOM/" production$i.inp
  sed -i "s/set prodid/set prodid $i/" production$i.inp
  ./qscript production$i.inp
done



