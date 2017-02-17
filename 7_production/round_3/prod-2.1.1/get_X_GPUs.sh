#!/bin/bash

if [ $# != 1 ]
then
    echo "Please provide a single argument specifying the number of required GPUs. Exiting..."
    exit 1
fi

expr $1 + 1 &> /dev/null
if [ $? != 0 ]
then
    echo "Please specify a valid number of GPUs."
    echo "Exiting..."
    exit 1
fi

wantedGPUs=$1

#work out the number of GPUs available on this node                                         
numgpus=`nvidia-smi -q -d PIDS | grep "Attached" | awk '{print $4}'`
echo "number of gpus: $numgpus"
j=0
i=0

if [ $wantedGPUs -gt 8 ]
then
    echo "Maximum number of GPUs that can be requested is 8! Exiting..."
fi

if [ $wantedGPUs -gt $numgpus ]
then
    echo "More GPUs requested than are available on the provided node."
    echo "If more than 3 GPUs are required please be sure to use #BSUB -m emerald8g in your job script"
    echo "Exiting..."
    exit 1
fi

#cycle through all gpus and record those that are free                                      
while [ $j -lt $numgpus ] && [ $i -lt $wantedGPUs ]
do
    procexcl=`nvidia-smi -i $j -q -d COMPUTE | grep "Compute"| awk '{print $4}'`
    used=`nvidia-smi -i $j -q -d PIDS | grep "Process"| awk '{print $3}'`
    nvidia-smi -i $j -q -d PIDS,COMPUTE
    if [ $procexcl = "Exclusive_Process" ] 
    then 
        echo "gpu $j processes: $used"
	    echo $used
        if [ $used = "None" ] 2> /dev/null
	    then
            freeGPUs[$i]=$j
            let i++
        fi
    fi
    let j++
done

#check that there are enough free GPUs                                                      
if [ $i -lt $wantedGPUs ]; then
    echo "ERROR: Not enough free GPUs, wanted $wantedGPUs but could only get $i. Exiting..."
    exit 1
fi

echo "Using GPUs" ${freeGPUs[@]}

#comma separated list of GPU devices to use                                                 
GPUlist=`echo ${freeGPUs[@]}`
export CUDA_VISIBLE_DEVICES=${GPUlist//" "/","}
echo "CUDA_VISIBLE_DEVICES" $CUDA_VISIBLE_DEVICES


