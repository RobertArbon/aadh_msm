#!/bin/bash

for i in {1..10}
do
  for j in {1..10} 
  do 
    fileroot=production$i.$j
    status=`qq | grep "$fileroot " | awk '{print $5}'`
    if [[ !  -z  $status  ]] 
    then
      if [ $status == "Q" ]; then
         echo "$fileroot : Queuing"
      elif [ $status == "R" ]; then
         lastiter=`grep "DYNA>" ./prod-$i/prod-$i.$j/$fileroot.out | tail -n 1 | awk '{print $2}'`
         echo "$fileroot : Running, at timestep $lastiter" 
      fi
    else
     if grep -q "NORMAL TERMINATION BY NORMAL STOP" ./prod-$i/prod-$i.$j/$fileroot.out; then 
      lastiter=`grep "DYNA>" ./prod-$i/prod-$i.$j/$fileroot.out | tail -n 1 | awk '{print $2}'`
      echo "$fileroot : Completed, last timestep $lastiter" 
     else
      echo "$fileroot : Unknown status"
     fi
    fi 
  done
done

