map = []

File.open('input.txt').readlines.map(&:chomp).each do |line|
  break if line == ""

  map << [line.split(',')[0].to_i, line.split(',')[1].to_i]
end

# fold along x=655

def push_dot(indice, is_x, map, point)
  if is_x
    if point[0] > indice
      map << [2 * indice - point[0], point[1]]
    else
      map << point
    end
  else
    if point[1] > indice
      map << [point[0], 2 * indice - point[1]]
    else
      map << point
    end
  end
  map
end

instructions = ["fold along x=655"]
folded_map = []

instructions.each do |instruction|
  map.each do |point|
    folded_map = push_dot(instruction.split("=")[1].to_i, instruction.include?("x"), folded_map, point)
  end
end
p folded_map.length
