from file_read_backwards import FileReadBackwards
import pandas as pd
import sys
def start_end_time(script_address,target):
    file = open(script_address)
    line = file.readline()
    while line:
        line = file.readline()
        if target in line:
            startime = float(line.split()[3][:-1])
            print("Start time: ",startime)
            break
    with FileReadBackwards(script_address, encoding="utf-8") as backFile:
    # getting lines by lines starting from the last line up
        for line in backFile:
            if target in line:
                endtime = float(line.split()[3][:-1])
                print("End time: ",endtime)
                break
    return startime,endtime

def runtime(address,start,end,target):
    file = open(address)
    line = file.readline()
    while line:
        line = file.readline()
        if "----" in line:
            break

    dataline = file.readline()
    num = 0
    total_runtime = 0
    while dataline:
        if target in dataline:
            datalist = dataline.split()
            timestep = float(datalist[0])
            if start <= timestep and end >= timestep:
                #print(dataline)
                #find the right for target
                num = num+1
                runtime = float(datalist[5])
                total_runtime = total_runtime +runtime
        dataline = file.readline()
    file.close()
    print("The number of %s : %d"%(target,num))
    print("Total runtime for %s: %f"%(target,total_runtime))
    return num, total_runtime

def result(script_address,timehist_address):
    print("--------------------------Address----------------------------------")
    print("Script address: ",script_address)
    print("Timehist address: ",timehist_address)
    print("-------------------Start and End time-------------------------------")
    start,end = start_end_time(script_address,"hello")
    print("-------------------Information of Fio-------------------------------")
    target = "fio"
    fio_num,fio_runtime = runtime(timehist_address,start,end,target)
    print("-------------------Information of hello-----------------------------")
    target = "hello"
    hello_num,hello_runtime = runtime(timehist_address,start,end,target)
    total_time = (end - start)*1000
    off_cpu = total_time - hello_runtime - fio_runtime
    print("--------------------------Result-----------------------------------")
    print("On cpu of hello(ms): ",hello_runtime)
    print("On cpu of fio(ms): ",fio_runtime)
    print("Total time(ms): ",total_time)
    print("Off cpu(ms): ",off_cpu)
    df = pd.DataFrame(columns=('core','fuse_num', 'fio_num', 'fuse_run_time(ms)','fio_run_time(ms)','on_cpu_time(ms)','off_cpu_time(ms)','total_time(ms)','off/total(%)'))
    d = dict()
    d['fuse_num'] = hello_num
    d['fio_num'] = fio_num
    d['fuse_run_time(ms)'] = hello_runtime
    d['fio_run_time(ms)'] = fio_runtime
    d['on_cpu_time(ms)'] = fio_runtime+hello_runtime
    d['off_cpu_time(ms)'] = off_cpu
    d['total_time(ms)'] = total_time
    d['off/total(%)'] = off_cpu/total_time
    d['core'] = script_address.split("/")[-2]
    df = df.append(d,ignore_index=True)

    return df

script_address = sys.argv[1]
timehist_address = sys.argv[2]
csv_address = sys.argv[3]
print("csv:",csv_address)
df = result(script_address,timehist_address)
with open(csv_address, mode = 'a') as f:
    df.to_csv(f, header=f.tell()==0,index = False)
    print("please find the result in: ",csv_address)
