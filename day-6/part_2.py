# import sys
# from collections import Counter

# line = [int(x) for x in sys.stdin.read().strip().split(',')]

# def simulate(line, days):
#     counter = Counter(line)
#     m = [counter.get(i, 0) for i in range(9)]
#     for _day in range(days):
#         n_reset = m[0]
#         for i in range(8):
#             m[i] = m[i+1]
#         m[6] += n_reset
#         m[8] = n_reset
#     return sum(m)

# print('Part 1:', simulate(line, 80))
# print('Part 2:', simulate(line, 256))

from copy import deepcopy

# parse data
with open("input.txt") as f:
    data = [int(x) for x in f.read().split(",")]

# Using a dict to store the number of fishes which are in a certain day of the cycle.
fishes = {"d0": 0, "d1": 0, "d2": 0, "d3": 0, "d4": 0, "d5": 0, "d6": 0, "d7": 0, "d8": 0}
for f in data:
    fishes["d"+str(f)] += 1

# Iterate over days
fishes_new = {"d0": 0, "d1": 0, "d2": 0, "d3": 0, "d4": 0, "d5": 0, "d6": 0, "d7": 0, "d8": 0}
for day in range(256):
    for fishday in fishes:
        if int(fishday[1]) == 0:  # respawn day
            fishes_new["d6"] += fishes[fishday]
            fishes_new["d8"] += fishes[fishday]
        else:  # subtract one day.
            fishes_new["d" + str(int(fishday[1])-1)] += fishes[fishday]
    # reset for the next day
    fishes = deepcopy(fishes_new)
    fishes_new = {"d0": 0, "d1": 0, "d2": 0, "d3": 0, "d4": 0, "d5": 0, "d6": 0, "d7": 0, "d8": 0}


count_fishes = 0
for key in fishes:
    count_fishes += fishes[key]
print(count_fishes)
