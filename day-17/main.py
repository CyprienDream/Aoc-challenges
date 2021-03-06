from itertools import product

def check_velocity_valid(dx, dy, target):
    tminx, tmaxx, tminy, tmaxy = target
    pos_x, pos_y = 0, 0
    while pos_x <= tmaxx and pos_y >= tminy:
        pos_x, pos_y, dx, dy = pos_x+dx, pos_y+dy, max(0, dx-1), dy-1
        if tminx <= pos_x <= tmaxx and tminy <= pos_y <= tmaxy:
            return True
    return False

def highest_y(y):
    return (y+1) * y // 2

target = 282, 314, -80, -45
velocities = [dy for dx, dy in product(range(1000), range(-1000, 1000)) if check_velocity_valid(dx, dy, target)]
print(highest_y(max(velocities)))
print(len(velocities))
