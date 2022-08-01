source /home/azureuser/zzy/libfuse/build/Script/VARIABLE

cd $sadd
mkdir $sadd/result
bash $sadd/fio_numjob.sh > $sadd/result/fio_result_numjob
echo "--------------------------------------------------------------"
echo "Run Python script to get csv file"
INPUT_PATH=''$sadd'/result/fio_result_numjob'
OUTPUT_PATH=''$sadd'/result/fio_result_numjob.csv'
python3 $sadd/fio_cross.py "$INPUT_PATH" "$OUTPUT_PATH"
echo "Please find result in this address: $sadd/result/fio_result_numjob.csv"
echo "----------------Draw Graph--------------------------------------"
mkdir $sadd/result/fio_numjob
INPUT_PATH=''$sadd'/result/fio_result_numjob.csv'
OUTPUT_PATH=''$sadd'/result/fio_numjob/'
python3 $sadd/depth_graph.py "$INPUT_PATH" "$OUTPUT_PATH"
