# reads file data
def parse_file
  File.open('input.txt').readlines.map(&:chomp)
end

# parses line into array with four elements
def parse_line(line)
  line.gsub('->', ',').split(',').map(&:to_i)
end

# parses all lines
def lines_array
  lines = []
  parse_file.each do |text_line|
    lines << parse_line(text_line)
  end
  lines
end

# adds all coordinates present on line to coordinates array
def add_line_coordinates(min, max, is_x_stable, stable, coordinates)
  (min..max).each do |i|
    coordinates << (is_x_stable ? [stable, i] : [i, stable])
  end
end

# build hash with number of lines passing through each coordinate
def build_weights_hash(coordinates)
  weights = Hash.new(0)
  coordinates.each do |coordinate|
    weights[coordinate.flatten] += 1
  end
  weights
end

coordinates = []
# delete if statement removes non horizontal and vertical lines
lines_array(parse_file).delete_if { |line| line[0] != line[2] && line[1] != line[3] }.each do |line|
  if line[0] != line[2]
    if line[0] < line[2]
      add_line_coordinates(line[0], line[2], false, line[3], coordinates)
    else
      add_line_coordinates(line[2], line[0], false, line[3], coordinates)

    end
  elsif line[1] < line[3]
    add_line_coordinates(line[1], line[3], true, line[0], coordinates)
  else
    add_line_coordinates(line[3], line[1], true, line[0], coordinates)
  end
end

weights = build_weights_hash(coordinates)
p part1_answer = weights.delete_if { |_, value| value < 2 }.length
