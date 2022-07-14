source /home/azureuser/zzy/libfuse/example/Script/VARIABLE

mkdir $sadd/result
mkdir $sadd/result/perf_stat_folder

INPUT_PATH=''$sadd'/result/perf_stat'
OUTPUT_PATH=''$sadd'/result/perf_stat_folder/perf_stat_event.csv'
python3 $sadd/perf_stat_hardware_event.py "$INPUT_PATH" "$OUTPUT_PATH"

INPUT_PATH=''$sadd'/result/perf_stat_folder/perf_stat_event.csv'
OUTPUT_PATH=''$sadd'/result/perf_stat_folder/'
python3 $sadd/depth_graph.py "$INPUT_PATH" "$OUTPUT_PATH"
