#!/bin/awk -f

{count[$4]++} 
END {
    for(j in count){
        if(j == "TIP3"){
            x = count[j]/3
        }else{
            x = count[j]}
        print j,x
    } 
}



