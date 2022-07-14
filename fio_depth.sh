source /home/azureuser/zzy/libfuse/example/Script/VARIABLE
cd $add
echo "---------------Test depth----------------------"
read -p "Do you want to contine? if yes, please input the depth, if no, please input -1: " flag
while (($flag >0));
do
    read -p "Enter fio cpu: " fio_cpu
    read -p "Enter fuse cpu: " file_cpu
    taskset -c $file_cpu $add/$name /tmp/fuse -s

    echo '------------------------------------------------------'
    echo '1. print cpu setting----------------------------------'
    echo "$name taskset for cpu: $file_cpu"
    echo "Fio taskset for cpu: $fio_cpu" 
    echo '2. print command line---------------------------------'
    echo "taskset -c $file_cpu $add/$name /tmp/fuse -s"
    taskset -c $file_cpu $add/$name /tmp/fuse -s
    
    while (($flag>0));
    do
        echo '3. begin fio test without perf----------------------------------'
        echo "$name taskset for cpu: $file_cpu"
        echo "Fio test for cpu: $fio_cpu" 
        echo "Depth:" $flag
        echo "taskset -c $fio_cpu fio --filename=/tmp/fuse/hello --direct=1 --rw=randwrite --bs=4k --ioengine=libaio --iodepth=$flag --name=fuse-1-ro-1 --loop=1"
        taskset -c $fio_cpu fio --filename=/tmp/fuse/hello --direct=1 --rw=randwrite --bs=4k --ioengine=libaio --iodepth=$flag --name=fuse-1-ro-1 --loop=1 
        ((flag--))
    done
    
    fusermount -u /tmp/fuse
    pid=$(pgrep -f $name)
    echo "kill $pid"
    kill $pid
    sleep 5
    read -p "Do you want to contine? if yes, please input the depth, if no, please input -1: " flag
done
