def draw(feature,output_address):
    start = 0
    df_same = pd.DataFrame()
    df_diff = pd.DataFrame()
    for i in range(len(df)):
        if df.loc[i]['QD'] ==1:
            file_cpu = df.loc[i]["fuse_cpu"]
            fio_cpu = df.loc[i]["fio_cpu"]
            column_name = "fuse_"+str(file_cpu)+"_fio_"+str(fio_cpu)
            if file_cpu == fio_cpu:
                temp = df[start:i+1][['QD',feature]]
                if len(df_same)==0:
                    temp = temp.rename(columns={feature:column_name})
                    df_same = temp
                else:
                    df_same.insert(loc=len(df_same.columns), column=column_name, value=temp[feature].to_frame())
            else:
                temp = df[start:i+1][['QD',feature]]
                if len(df_diff)==0:
                    temp = temp.rename(columns={feature:column_name})
                    df_diff = temp
                else:
                    df_diff.insert(loc=len(df_diff.columns), column=column_name, value=temp[feature].to_frame())
            start = i+1


    title_same = feature+"_with_multithread"
    # title_diff = feature+"_with_different_core"

    title_same_address = output_address+title_same+".png"
    # title_diff_address = output_address+title_diff+".png"

    fig_same = df_same.plot(x = 'QD',grid=True,title = title_same)
    fig_same = fig_same.get_figure()
    fig_same.savefig(title_same_address)

    # fig_diff = df_diff.plot(x = 'QD',grid=True,title = title_diff)
    # fig_diff = fig_diff.get_figure()
    # fig_diff.savefig(title_diff_address)

import matplotlib.pyplot as plt
import pandas as pd
import sys
input_address = sys.argv[1]
output_address = sys.argv[2]

df = pd.read_csv(input_address)
list_name = df.columns
while True:
    for i in range(len(list_name)):
        print(i,":",list_name[i])
    num = input("Please input number above to get the feature you want\nif you do not want to continue please enter -1: ")
    if int(num) == -1:
        break
    feature = list_name[int(num)]
    print(feature)
    draw(feature,output_address)