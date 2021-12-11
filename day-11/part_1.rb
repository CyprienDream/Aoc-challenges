# map = File.read("input.txt").strip.split("\n").map do |line|
#   line.chars.map(&:to_i)
# end

# p map

# def increase_adjacent(line_i, num_i, map)
#   map[line_i][num_i + 1] += 1 if map[line_i][num_i + 1]
#   map = increase_adjacent(line_i, num_i + 1, map) if map[line_i][num_i + 1] && map[line_i][num_i + 1] > 9

#   map[line_i][num_i - 1] += 1 if map[line_i][num_i - 1]
#   map = increase_adjacent(line_i, num_i - 1, map) if map[line_i][num_i - 1] && map[line_i][num_i - 1] > 9

#   map[line_i - 1][num_i] += 1 if map[line_i - 1][num_i]
#   map = increase_adjacent(line_i - 1, num_i, map) if  map[line_i - 1][num_i] && map[line_i - 1][num_i] > 9

#   map[line_i - 1][num_i + 1] += 1 if  map[line_i - 1][num_i + 1]
#   map = increase_adjacent(line_i - 1, num_i + 1, map) if map[line_i - 1][num_i + 1] && map[line_i - 1][num_i + 1] > 9

#   map[line_i - 1][num_i - 1] += 1 if map[line_i - 1][num_i - 1]
#   map = increase_adjacent(line_i - 1, num_i - 1, map) if map[line_i - 1][num_i - 1] && map[line_i - 1][num_i - 1] > 9

#   map[line_i + 1][num_i] += 1 if map[line_i + 1][num_i]
#   map = increase_adjacent(line_i + 1, num_i, map) if map[line_i + 1][num_i] && map[line_i + 1][num_i] > 9

#   map[line_i + 1][num_i + 1] += 1 if map[line_i + 1][num_i + 1]
#   map = increase_adjacent(line_i + 1, num_i + 1, map) if map[line_i + 1][num_i + 1] && map[line_i + 1][num_i + 1] > 9

#   map[line_i + 1][num_i - 1] += 1 if map[line_i + 1][num_i - 1]
#   map = increase_adjacent(line_i + 1, num_i - 1, map) if  map[line_i + 1][num_i - 1] && map[line_i + 1][num_i - 1] > 9

#   map
# end

# 100.times do
#   map.each_with_index do |line, line_i|
#     p line
#     line.each_with_index do |num, num_i|
#       map[line_i][num_i] += 1
#       if num > 9
#         map = increase_adjacent(line_i, num_i, map)
#         map[line_i][num_i] = 0
#       end
#     end
#   end
# end


map = File.read('input.txt').lines(chomp: true).map { |l| l.split(//).map(&:to_i) }

def flash(map, y, x)
  flashed = 1
  (([y-1, 0].max)..([y+1, map.size-1].min)).each do |yp|
    (([x-1, 0].max)..([x+1, map[y].size-1].min)).each do |xp|
      map[yp][xp] += 1
      if map[yp][xp] == 10
        flashed += flash(map, yp, xp)
      end
    end
  end
  flashed
end

# part 1
flashed = 0
100.times do
  map.size.times do |y|
    map[y].size.times do |x|
      map[y][x] += 1
      flashed += flash(map, y, x) if map[y][x] == 10
    end
  end
  map.size.times do |y|
    map[y].size.times do |x|
      map[y][x] = 0 if map[y][x] > 9
    end
  end
end
puts flashed

# part 2
(0..).each do |i|
  flashed = 0
  map.size.times do |y|
    map[y].size.times do |x|
      map[y][x] += 1
      flashed += flash(map, y, x) if map[y][x] == 10
    end
  end
  map.size.times do |y|
    map[y].size.times do |x|
      map[y][x] = 0 if map[y][x] > 9
    end
  end
  if flashed == map.size * map[0].size
    puts i+1
    exit
  end
end
