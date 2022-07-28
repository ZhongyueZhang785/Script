#! /bin/bash
clear
source /home/azureuser/zzy/libfuse/example/Script/VARIABLE

echo '---------------Fuse Latency Optimization--------------'
read -p "Enter cpu starting number: " snum  
read -p "Enter cpu ending: " enum 

echo '---------------Begin test-------------------------------' 
while [[ $snum -le $enum ]];
    do
        let i=0
        taskset -c $snum $add/$name /tmp/fuse -s
        pid=$(pgrep -f $name)

        while [[ $i -le $enum ]];  
        do  
        echo '------------------------------------------------------'
        echo '1. print cpu setting----------------------------------'
        echo "$name taskset for cpu: $snum"
        echo "Fio test for cpu: $i"  

        echo '2. print command line---------------------------------'
        echo "taskset -c $snum $add/$name /tmp/fuse -s"
        echo "taskset -c $i fio --filename=/tmp/fuse/hello --direct=1 --rw=randwrite --bs=4k --ioengine=libaio --iodepth=1 --name=fuse-1-ro-1 --loop=1"
        
        echo '3. begin fio test without perf----------------------------------'
        echo "$name taskset for cpu: $snum"
        echo "Fio test for cpu: $i"  
        taskset -c $i fio --filename=/tmp/fuse/hello --direct=1 --rw=randwrite --bs=4k --ioengine=libaio --iodepth=1 --name=fuse-1-ro-1 --loop=1 
        ((i++))  
        done 

    echo "-------------------kill $name------------------------------"
    fusermount -u /tmp/fuse
    echo "kill $pid"
    kill $pid
    sleep 5
    ((snum++))
done 






