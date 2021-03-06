#! /bin/bash
source /home/azureuser/zzy/libfuse/example/Script/VARIABLE
echo "---------------Perf stat-Hardware event----------------------"
read -p "Do you want to contine? if yes, please input 1: " flag
cd $add
while (($flag >0));
do
    read -p "Enter fio cpu: " fio_cpu
    read -p "Enter fuse cpu: " file_cpu
    read -p "Enter maximum depth you want: " depth
    mkdir ''$sadd'/result'
    
    echo "taskset -c $file_cpu $add/$name /tmp/fuse -s" 
    taskset -c $file_cpu $add/$name /tmp/fuse -s
    while(($depth>0));
    do
    echo "print setting----------------------------------"
    echo "Fuse taskset for cpu:$file_cpu"
    echo "Fio taskset for cpu:$fio_cpu"
    echo "Depth:$depth"
    echo "perf stat -e task-clock -e context-switches -e cpu-migrations -e page-faults -e cycles -e instructions -e branches -e branch-misses -e bus-cycles -e cache-misses -e cache-references -e cpu-cycles -e ref-cycles -e L1-dcache-load-misses -e L1-dcache-loads -e L1-dcache-stores -e L1-icache-load-misses -e branch-load-misses -e branch-loads -e dTLB-load-misses -e dTLB-loads -e dTLB-store-misses -e dTLB-stores -e iTLB-load-misses -e iTLB-loads taskset -c $fio_cpu fio --filename=/tmp/fuse/hello --direct=1 --rw=randwrite --bs=4k --ioengine=libaio --iodepth=$depth --name=fuse-1-ro-1 --loop=1"
    perf stat -e task-clock -e context-switches -e cpu-migrations -e page-faults -e cycles -e instructions -e branches -e branch-misses -e bus-cycles -e cache-misses -e cache-references -e cpu-cycles -e ref-cycles -e L1-dcache-load-misses -e L1-dcache-loads -e L1-dcache-stores -e L1-icache-load-misses -e branch-load-misses -e branch-loads -e dTLB-load-misses -e dTLB-loads -e dTLB-store-misses -e dTLB-stores -e iTLB-load-misses -e iTLB-loads taskset -c $fio_cpu fio --filename=/tmp/fuse/hello --direct=1 --rw=randwrite --bs=4k --ioengine=libaio --iodepth=$depth --name=fuse-1-ro-1 --loop=1
    ((depth--))
    done
    
    fusermount -u /tmp/fuse
    pid=$(pgrep -f $name)
    echo "kill $pid"
    kill $pid
    read -p "Do you want to contine? if yes, please input 1: " flag
done