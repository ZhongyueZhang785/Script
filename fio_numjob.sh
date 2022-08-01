source /home/azureuser/zzy/nonblocking/abcdzz1/libfuse/build/Script/VARIABLE
cd $add
echo "---------------Test depth MultiThread----------------------"
read -p "Do you want to contine? if yes, please input the numjob, if no, please input -1: " flag
numjob=1
while (($flag >=$numjob));
do
    fio_cpu="random"
    file_cpu="random"
    echo '------------------------------------------------------'
    echo '1. print cpu setting----------------------------------'
    echo "$name taskset for cpu: $file_cpu"
    echo "Fio taskset for cpu: $fio_cpu" 
    echo '2. print command line---------------------------------'
    echo "$add/$name /tmp/fuse"
    $add/$name /tmp/fuse
    
    while (($flag >=$numjob));
    do
        echo '3. begin fio test without perf----------------------------------'
        echo "$name taskset for cpu: $file_cpu"
        echo "Fio test for cpu: $fio_cpu" 
        echo "Depth:" $numjob
        echo "fio --filename=/tmp/fuse/hello --direct=1 --rw=randwrite --bs=4k --ioengine=libaio --iodepth=1 --name=fuse-1-ro-1 --loop=1 --numjobs=$numjob --group_reporting"
        fio --filename=/tmp/fuse/hello --direct=1 --rw=randwrite --bs=4k --ioengine=libaio --iodepth=1 --name=fuse-1-ro-1 --loop=1 --numjobs=$numjob --group_reporting
        ((numjob++))
        sleep 10
    done
    
    fusermount -u /tmp/fuse
    pid=$(pgrep -f $name)
    echo "kill $pid"
    kill $pid
    sleep 5
    read -p "Do you want to contine? if yes, please input the depth, if no, please input -1: " flag
done
