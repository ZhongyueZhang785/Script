source /home/zy/libfuse/build/Script/VARIABLE
cd $add
echo "---------------Test depth----------------------"
read -p "Please input the max numjobs you want: " flag
read -p "Please input the QD you want: " QD
numjobs=1
fio_cpu="x"
file_cpu=0

echo "taskset -c $file_cpu $add/$name /tmp/fuse -s"
taskset -c $file_cpu $add/$name /tmp/fuse -s
    
while (($flag >= $numjobs));
do
    echo '3. begin fio test without perf----------------------------------'
    echo "$name taskset for cpu: $file_cpu"
    echo "Fio test for cpu: $fio_cpu" 
    echo "Depth:" $QD
    echo "fio --filename=/tmp/fuse/hello --direct=1 --rw=randwrite --bs=4k --ioengine=libaio --iodepth=$QD --name=fuse-1-ro-1 --loop=1 --numjobs=$numjobs --group_reporting"
    fio --filename=/tmp/fuse/hello --direct=1 --rw=randwrite --bs=4k --ioengine=libaio --iodepth=$QD --name=fuse-1-ro-1 --loop=1 --numjobs=$numjobs --group_reporting
    ((numjobs++))
    sleep 5
done

fusermount -u /tmp/fuse
pid=$(pgrep -f $name)
echo "kill -9 $pid"
kill -9 $pid


