#! /bin/bash
source /home/azureuser/zzy/libfuse/example/Script/VARIABLE

echo "---------------CPU FlameGraph----------------------"
read -p "Do you want to contine? if yes, please input 1: " flag
cd $add
while (($flag >0));
do
    read -p "Enter fio cpu: " fio_cpu
    read -p "Enter fuse cpu: " file_cpu
    mkdir ''$sadd'/result'
    mkdir ''$sadd'/result/fuse_'$file_cpu'_fio_'$fio_cpu''

    echo "taskset -c $file_cpu $add/$name/tmp/fuse -s"| tee ''$sadd'/result/fuse_'$file_cpu'_fio_'$fio_cpu'/record_cpu_script'
    taskset -c $file_cpu $add/$name /tmp/fuse -s

    echo "perf record -e sched:sched_stat_sleep -e sched:sched_switch -e sched:sched_process_exit -a -g -o perf.data -- taskset -c $fio_cpu  fio --filename=/tmp/fuse/hello --direct=1 --rw=randwrite --bs=4k --ioengine=libaio --iodepth=1 --name=fuse-1-ro-1 --loop=1| tee ''$sadd'/result/fuse_'$file_cpu'_fio_'$fio_cpu'/record_cpu'" | tee -a ''$sadd'/result/fuse_'$file_cpu'_fio_'$fio_cpu'/record_cpu_script'
    perf record -a -g taskset -c $fio_cpu fio --filename=/tmp/fuse/hello --direct=1 --rw=randwrite --bs=4k --ioengine=libaio --iodepth=1 --name=fuse-1-ro-1 --loop=1 > ''$sadd'/result/fuse_'$file_cpu'_fio_'$fio_cpu'/record_cpu'
    perf script > ''$sadd'/result/fuse_'$file_cpu'_fio_'$fio_cpu'/script_cpu'
    perf script | $cadd/stackcollapse-perf.pl > out.perf-folded
    cat out.perf-folded | $cadd/flamegraph.pl > ''$sadd'/result/fuse_'$file_cpu'_fio_'$fio_cpu'/fuse_'$file_cpu'_fio_'$fio_cpu'_perf_kernel.svg'
    rm out.perf-folded
    pid=$(pgrep -f $name)
    echo "kill $pid"
    kill $pid
    read -p "Do you want to contine? if yes, please input 1: " flag
done