import pandas as pd
import sys
def perf_stat_event(input,output):
    name_list = ["task-clock",
    "context-switches",
    "cpu-migrations",
    "cpu-migrations",
    "page-faults",
    "cycles",
    "instructions",
    "branches",
    "branch-misses",
    "bus-cycles",
    "cache-misses",
    "cache-references",
    "cpu-cycles",
    "ref-cycles",
    "L1-dcache-load-misses",
    "L1-dcache-loads",
    "L1-dcache-stores",
    "L1-icache-load-misses",
    "branch-load-misses",
    "branch-loads",
    "dTLB-load-misses",
    "dTLB-loads",
    "dTLB-store-misses",
    "dTLB-stores",
    "iTLB-load-misses",
    "iTLB-loads"]

    df = pd.DataFrame()
    result = dict()
    with open(input, 'r', encoding='utf-8') as f:
        for line in f:
            if "Fuse taskset for cpu" in line:
                result["fuse_cpu"] = int(line.split(":")[-1])
            if "Fio taskset for cpu" in line:
                result["fio_cpu"] = int(line.split(":")[-1])
            if "Depth:" in line:
                result["QD"] = int(line.split(":")[-1])
            for name in name_list:
                if name in line and "perf stat" not in line:
                    if name == "task-clock":
                        datalist = line.split()
                        result["task-clock"] = float(datalist[0])
                        result["cpu_utilized"] = float(datalist[4])
                    if "not supported" not in line:
                        datalist = line.split()
                        result[name] = float(datalist[0])
                    if name == "iTLB-loads":
                        d = pd.DataFrame([result])
                        df = df.append(d,ignore_index=True)
                        result = dict()

    df.to_csv(output, index = False)

input_address = sys.argv[1]
output_address = sys.argv[2]

perf_stat_event(input_address,output_address)
