#! /bin/bash
source /home/azureuser/zzy/libfuse/example/Script/VARIABLE

echo "---------------Calculate off/on cpu time----------------------"
read -p "Do you want to contine? if yes, please input 1: " flag
cd $add
while (($flag >0));
do
    read -p "Enter fio cpu: " fio_cpu
    read -p "Enter fuse system cpu: " file_cpu
    mkdir ''$sadd'/result'
    mkdir ''$sadd'/result/fuse_'$file_cpu'_fio_'$fio_cpu''
    echo "taskset -c $file_cpu $add/$name /tmp/fuse -s"| tee ''$sadd'/result/fuse_'$file_cpu'_fio_'$fio_cpu'/record'
    taskset -c $file_cpu $add/$name /tmp/fuse -s

    echo "perf record -e sched:sched_stat_sleep -e sched:sched_switch -e sched:sched_process_exit -a -g -o perf.data -- taskset -c $fio_cpu  fio --filename=/tmp/fuse/hello --direct=1 --rw=randwrite --bs=4k --ioengine=libaio --iodepth=1 --name=fuse-1-ro-1 --loop=1| tee ''$sadd'/result/fuse_'$file_cpu'_fio_'$fio_cpu'/record'" | tee -a ''$sadd'/result/fuse_'$file_cpu'_fio_'$fio_cpu'/record'
    perf record -e sched:sched_stat_sleep -e sched:sched_switch -e sched:sched_process_exit -a -g -o perf.data -- taskset -c $fio_cpu  fio --filename=/tmp/fuse/hello --direct=1 --rw=randwrite --bs=4k --ioengine=libaio --iodepth=1 --name=fuse-1-ro-1 --loop=1| tee -a ''$sadd'/result/fuse_'$file_cpu'_fio_'$fio_cpu'/record'
    perf script > ''$sadd'/result/fuse_'$file_cpu'_fio_'$fio_cpu'/script'
    perf sched timehist > ''$sadd'/result/fuse_'$file_cpu'_fio_'$fio_cpu'/timehist'

    script_address=''$sadd'/result/fuse_'$file_cpu'_fio_'$fio_cpu'/script'
    timehist_address=''$sadd'/result/fuse_'$file_cpu'_fio_'$fio_cpu'/timehist'
    csv_address=''$sadd'/result/on_off_cpu.csv'
    
    echo "----------------Begin calculating--------------------------"
    FILE_NAME='off_on_cpu.py'
    PYTHON_PATH=$sadd/$FILE_NAME
    python3 $PYTHON_PATH "$script_address" "$timehist_address" "$csv_address"

    pid=$(pgrep -f $name)
    echo "kill $pid"
    kill $pid
    read -p "Do you want to contine? if yes, please input 1: " flag
done