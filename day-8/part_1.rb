def parse_file
  lines = []
  File.open('input.txt').readlines.map(&:chomp).each do |line|
    lines << line.split('|')[1]
  end
  lines
end

p parse_file

weights = Hash.new(0)

parse_file.each do |output|
  output.split(" ").each do |word|
    weights[word.length] += 1
  end
end

p weights
part_1 = weights[2] + weights[4] + weights[7] + weights[3]
p part_1
