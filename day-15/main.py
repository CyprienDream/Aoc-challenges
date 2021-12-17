from collections import Counter, defaultdict, deque
from heapq import heappop, heappush

with open("input.txt") as f:
    data = [list(map(int, line)) for line in f.read().strip().split("\n")]

heap = [(0, 0, 0)]
seen = {(0, 0)}
while heap:
    distance, x, y = heappop(heap)
    if x == len(data) - 1 and y == len(data[0]) - 1:
        print(distance)
        break

    for dx, dy in ((0, 1), (0 , -1), ( 1, 0), (-1, 0)):
        x_, y_ = x + dx, y + dy
        # if 0 <= x_ < len(data) and 0 <= y_ < len(data[0]):
        if x_ < 0 or y_ < 0 or x_ >= len(data) or y_ >= len(data):
            continue

        a, am = divmod(x_, len(data))
        b, bm = divmod(y_, len(data[0]))
        n = ((data[am][bm] + a + b) - 1) % 9 + 1

        if (x_, y_) not in seen:
            seen.add((x_, y_))
            heappush(heap, (distance + n, x_, y_))
