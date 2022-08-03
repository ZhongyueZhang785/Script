source /home/zy/zzy/baseline4/libfuse/build/Script/VARIABLE
cd $add
echo "---------------Test depth----------------------"
read -p "Please input the max depth you want: " flag
depth=1
fio_cpu="x"
file_cpu="x"

echo "$add/$name /tmp/fuse -s"
$add/$name /tmp/fuse -s
    
while (($flag >= $depth));
do
    echo '3. begin fio test without perf----------------------------------'
    echo "$name taskset for cpu: $file_cpu"
    echo "Fio test for cpu: $fio_cpu" 
    echo "Depth:" $depth
    echo "fio --filename=/tmp/fuse/hello --direct=1 --rw=randwrite --bs=4k --ioengine=libaio --iodepth=$depth --name=fuse-1-ro-1 --loop=1 --numjobs=1 --group_reporting"
    fio --filename=/tmp/fuse/hello --direct=1 --rw=randwrite --bs=4k --ioengine=libaio --iodepth=$depth --name=fuse-1-ro-1 --loop=1 --numjobs=1 --group_reporting
    ((depth++))
    sleep 5
done

read -p "Please input the max depth you want and we would begin with 2 times: " flag
((depth--))
while (($flag >= $depth));
do
    echo '3. begin fio test without perf----------------------------------'
    echo "$name taskset for cpu: $file_cpu"
    echo "Fio test for cpu: $fio_cpu" 
    echo "Depth:" $depth
    echo "fio --filename=/tmp/fuse/hello --direct=1 --rw=randwrite --bs=4k --ioengine=libaio --iodepth=$depth --name=fuse-1-ro-1 --loop=1 --numjobs=1 --group_reporting"
    fio --filename=/tmp/fuse/hello --direct=1 --rw=randwrite --bs=4k --ioengine=libaio --iodepth=$depth --name=fuse-1-ro-1 --loop=1 --numjobs=1 --group_reporting
    depth=$(($depth+$depth))
    sleep 5
done



fusermount -u /tmp/fuse
pid=$(pgrep -f $name)
echo "kill -9 $pid"
kill -9 $pid


