# **Readme**
This script contains four function to measure fuse kernel

1. Latency

2. Latency with depth

3. CPU FlameGraph

4. on/off cpu time

5. Hardware event ( perf stat)
   
   
# **Install libfuse**

### Install Meson

````
sudo apt install python3-pip

pip3 install --user meson

sudo vim /etc/profile

append this line to the file:  export PATH=~/.local/bin:$PATH

source /etc/profile

meson -v

````
### Install Ninja

````
sudo apt-get install python3 python3-pip ninja-build
````
### Download and Install libfuse
````
https://github.com/libfuse/libfuse
````



# **Prepration before test**
1. please set up the variable in VARIABLE

2. install the following pacakage
````
pip install file_read_backwards

pip install numpy

pip install pandas

pip install matplotlib

git clone https://github.com/brendangregg/FlameGraph
````

3. change the source in every xx_script.sh file

<!-- # **Performance Test**
## Step1: run fio_cross_script.sh
### Input: 
cpu start number and cpu ending number
### Output:
1. ./Script/result/fio_result_cross: the output of bash
2. ./Script/result/fio_result_cross.csv: the latency result of different combination of fio cpu core and fuse cpu core -->


## Step2: run fio_depth_script
### Input:
the depth you want and the cpu core number of fio and fuse
besides, you could also choose the graph you want to draw
### Output:
1. ./Script/result/fio_result_depth: the output of bash
2. you could also get the graph you want to draw under ./Script/result folder (e.g./Script/result/avg(us)_with_different_core.png)
3.  ./Script/result/fio_result_depth.csv: the stat result of differnt combination of the fio cpu core and fuse cpu core under different depth


<!-- ## Step3: run off_on_cpu_script.sh
### Input:
the cpu core number of fio and fuse
### Output:
1. ./Script/result/fuse_x_fio_x/record: the running command and fio output
2. ./Script/result/fuse_x_fio_x/script: perf script
3. ./Script/result/fuse_x_fio_x/timehist: perf timehist
4. ./Script/result/on_off_cpu.csv: the result of on and off cpu time -->


## Step4: run cpu_flamegraph.sh
### Input:
the cpu core number of fio and fuse
### Output:
1. ./Script/result/fuse_x_fio_x/record_cpu: the fio output
2. ./Script/result/fuse_x_fio_x/script_cpu: perf script
3. ./Script/result/fuse_x_fio_x/record_cpu_script: running command
4. ./Script/result/fuse_x_fio_x/fuse_x_file_x_perf_kernel.svg: cpu flamegraph

## Step5: perf stat event
run the following command
````
source xxx/Script/VARIABLE
source /home/azureuser/zzy/libfuse/example/Script/VARIABLE
OUTPUT_PATH=''$sadd'/result/perf_stat'
script $OUTPUT_PATH
	source xxx/Script/VARIABLE
	$sadd/perf_stat_hardware_event.sh
	input the cpu number of fio and fuse you want
exit
run perf_stat_hardware_event_script.sh and enter the feature you want
````

### Output:
1. ./Script/perf_stat: the record of all output
2. ./Script/perf_stat_event.csv: the csv file contain the perf stat number
3.  you could also get the graph you want to draw under ./Script/result/perf_stat_folder (e.g.task-clock_with_same_core.png)



