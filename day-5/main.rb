def parse_file
  File.open("input.txt").readlines.map(&:chomp)
end

def parse_line(line)
  line.gsub('->', ',').split(',').map(&:to_i)
end

# Hello World

lines = []

parse_file.each do |text_line|
  lines << parse_line(text_line)
end

coordinates = []

lines.delete_if {  |line| line[0] != line[2] && line[1] != line[3] }.each do |line|
  if line[0] != line[2]
    if line[0] < line[2]
      (line[0]..line[2]).each do |i|
        coordinates << [i, line[3]]
      end
    else
      (line[2]..line[0]).each do |i|
        coordinates << [i, line[3]]
      end
    end
  else
    if line[1] < line[3]
      (line[1]..line[3]).each do |i|
        coordinates << [line[0], i]
      end
    else
      (line[3]..line[1]).each do |i|
        coordinates << [line[0], i]
      end
    end
  end
end

weights = Hash.new(0)

coordinates.each do |coordinate|
  weights[coordinate.flatten] += 1
end

p weights.delete_if { |key, value| value < 2}.length
