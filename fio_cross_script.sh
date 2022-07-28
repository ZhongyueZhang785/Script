#! /bin/bash
source /home/azureuser/zzy/abcdzz1/libfuse/build/Script/VARIABLE

cd $sadd
mkdir $sadd/result
bash $sadd/fio_cross.sh > $sadd/result/fio_result_cross
echo "--------------------------------------------------------------"
echo "Run Python script to get csv file"
INPUT_PATH=''$sadd'/result/fio_result_cross'
OUTPUT_PATH=''$sadd'/result/fio_result_cross.csv'
python3 $sadd/fio_cross.py "$INPUT_PATH" "$OUTPUT_PATH"
echo "Please find result in this address: $sadd/result/fio_result_cross.csv"






