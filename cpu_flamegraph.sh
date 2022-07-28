#! /bin/bash
source /home/azureuser/zzy/abcdzz1/libfuse/build/Script/VARIABLE

echo "---------------CPU FlameGraph MultiThread----------------------"
read -p "Do you want to contine? if yes, please input 1: " flag
cd $add
while (($flag >0));
do
    
    fio_cpu="random"
    file_cpu="random"
    mkdir ''$sadd'/result'
    mkdir ''$sadd'/result/fuse_'$file_cpu'_fio_'$fio_cpu''

    echo "$add/$name /tmp/fuse "| tee ''$sadd'/result/fuse_'$file_cpu'_fio_'$fio_cpu'/record_cpu_script'
    $add/$name /tmp/fuse

    echo "perf record -e sched:sched_stat_sleep -e sched:sched_switch -e sched:sched_process_exit -a -g -o perf.data --fio --filename=/tmp/fuse/hello --direct=1 --rw=randwrite --bs=4k --ioengine=libaio --iodepth=1 --name=fuse-1-ro-1 --loop=1| tee ''$sadd'/result/fuse_'$file_cpu'_fio_'$fio_cpu'/record_cpu'" | tee -a ''$sadd'/result/fuse_'$file_cpu'_fio_'$fio_cpu'/record_cpu_script'
    perf record -a -g fio --filename=/tmp/fuse/hello --direct=1 --rw=randwrite --bs=4k --ioengine=libaio --iodepth=1 --name=fuse-1-ro-1 --loop=1 > ''$sadd'/result/fuse_'$file_cpu'_fio_'$fio_cpu'/record_cpu'
    perf script > ''$sadd'/result/fuse_'$file_cpu'_fio_'$fio_cpu'/script_cpu'
    perf script | $cadd/stackcollapse-perf.pl > out.perf-folded
    cat out.perf-folded | $cadd/flamegraph.pl > ''$sadd'/result/fuse_'$file_cpu'_fio_'$fio_cpu'/fuse_'$file_cpu'_fio_'$fio_cpu'_perf_kernel.svg'
    rm out.perf-folded
    pid=$(pgrep -f $name)
    echo "kill $pid"
    kill $pid
    read -p "Do you want to contine? if yes, please input 1: " flag
done