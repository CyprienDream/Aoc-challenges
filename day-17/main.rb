xrange, yrange = open("input").read.split(",").map{eval(_1.split("=").last)}

def triangular(n) = n * (n + 1) / 2
def loc(init_velocity, steps) = steps * ((init_velocity + (init_velocity - steps + 1)) / 2.0)
