import numpy as np
data,data1 = get_data(day=4)

def get_blocks(dt):
    block = []
    num = [int(i) for i in dt[0].split(",")]
    row = []
    tdata=[]
    blocks = 0
    for d in dt[2:]:
        if d == "":
            tdata.append(block)
            block=[]
            blocks+=1

        else:
            block.append([int(i) for i in d.strip().split(" ") if i!=""])
    tdata.append(block)
    block=[]
    blocks+=1
    tdata = np.array(tdata).reshape(blocks,-1, 5)
    return tdata, num

def get_first_matched(tdata, num):
    results = np.zeros_like(tdata).astype(np.bool)
    matched = False

    for n in num:
        for i,block in enumerate(tdata):
            results[i] += block==n
            # search across row
            if (results[i]==[ True,  True,  True,  True,  True]).all(axis=1).any():
                print(f"Row Matched Block:{i}")
                matched=True
                break

            # search across cols
            if (results[i].T==[ True,  True,  True,  True,  True]).all(axis=1).any():
                print(f"Col Matched Block: {i}")
                matched=True
                break
        if matched:
            print(f"\nResult Block: {tdata[i]}")
            s = (tdata[i]*~results[i]).sum()
            print(f"Sum: {s}")
            print(f"Last number: {n}")
            print(f"Answer: {n*s}\n")
            break

def get_last_matched(tdata, num):
    results = np.zeros_like(tdata).astype(np.bool)
    matched = False
    mblocks=[]
    all_blocks = list(range(0, len(results)))

    for n in num:
        for i,block in enumerate(tdata):
            results[i] += block==n
            # search across row
            if (results[i]==[ True,  True,  True,  True,  True]).all(axis=1).any():
                print(f"Row Matched Block:{i}")
                if i not in mblocks:
                    mblocks.append(i)
                if len(mblocks) == len(all_blocks):
                    matched=True

            # search across cols
            if (results[i].T==[ True,  True,  True,  True,  True]).all(axis=1).any():
                print(f"Col Matched Block: {i}")
                if i not in mblocks:
                    mblocks.append(i)
                if len(mblocks) == len(all_blocks):
                    matched=True

        if matched:
            i = mblocks[i]

            print(f"\nResult Block: {tdata[i]}")
            s = (tdata[i]*~results[i]).sum()
            print(f"Sum: {s}")
            print(f"Last number: {n}")
            print(f"Answer: {n*s}")
            break

d1,n1 = get_blocks(data1)
get_first_matched(tdata=d1, num=n1)
get_last_matched(tdata=d1, num=n1)
