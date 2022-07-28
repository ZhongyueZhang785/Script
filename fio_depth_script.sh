source /home/azureuser/zzy/libfuse/example/Script/VARIABLE

cd $sadd
mkdir $sadd/result
bash $sadd/fio_depth.sh > $sadd/result/fio_result_depth
echo "--------------------------------------------------------------"
echo "Run Python script to get csv file"
INPUT_PATH=''$sadd'/result/fio_result_depth'
OUTPUT_PATH=''$sadd'/result/fio_result_depth.csv'
python3 $sadd/fio_cross.py "$INPUT_PATH" "$OUTPUT_PATH"
echo "Please find result in this address: $sadd/result/fio_result_depth.csv"
echo "----------------Draw Graph--------------------------------------"
mkdir $sadd/result/fio_depth
INPUT_PATH=''$sadd'/result/fio_result_depth.csv'
OUTPUT_PATH=''$sadd'/result/fio_depth/'
python3 $sadd/depth_graph.py "$INPUT_PATH" "$OUTPUT_PATH"
