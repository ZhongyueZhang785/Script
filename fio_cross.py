import pandas as pd
import sys
df = pd.DataFrame(columns=('QD','fuse_cpu', 'fio_cpu', 'min(us)','max(us)','avg(us)','stdev(us)',
'cpu_usr(%)','cpu_sys(%)','cpu_ctx','cpu_majf','cpu_minf'))
input_address = sys.argv[1]
output_address = sys.argv[2]
f = open(input_address)
line = f.readline()
while line:
    if "3. begin fio test without perf" in line:
        filesystem_cpu = f.readline()[-2]
        fio_cpu = f.readline()[-2]
        result = dict()
        result["fuse_cpu"] = filesystem_cpu
        result["fio_cpu"] = fio_cpu
        print("fuse cpu: ",filesystem_cpu)
        print("fio cpu: ",fio_cpu)

        while True:
            if "Depth:" in line:
                depth = int(line.split(":")[-1])
                result['QD'] = depth
            elif "lat" in line and "min" in line and "max" in line and "avg" in line and "stdev" in line and "slat" not in line and "clat" not in line:
                print(line)
                data_list = line.strip().split(",")
                product = 1
                if "nsec" in data_list[0]:
                    product=0.001
                elif "usec" in data_list[0]:
                    product = 1
                else:
                    print("Please check the unit")
                    product = 0
                stat_name={0:"min(us)",1:"max(us)",2:"avg(us)",3:"stdev(us)"}
                for i in range(len(data_list)):
                    stat = float(data_list[i].split("=")[1])
                    result[stat_name[i]] = product*stat
            elif "cpu" in line and "usr" in line and "sys" in line and "ctx" in line and "majf" in line and "minf" in line:
                print(line)
                data_list = line.strip().split(",")
                stat_name={0:"cpu_usr(%)",1:"cpu_sys(%)",2:"cpu_ctx",3:"cpu_majf",4:"cpu_minf"}
                for i in range(len(data_list)):
                    stat = data_list[i].split("=")[1]
                    if i<2:
                        stat = stat[:-1]
                    result[stat_name[i]] = float(stat)
                df = df.append(result,ignore_index=True)
                print(result)
                break
            
            line = f.readline()
    line = f.readline()
f.close()
df.to_csv(output_address, index=False)

