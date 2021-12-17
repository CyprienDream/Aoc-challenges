data = File.open('input.txt').readlines.map(&:chomp)
map = {}

data.each_with_index do |line, y|
  line.chars.each_with_index do |char, x|
    map[[x, y]] = char.to_i
  end
end
p map
# [[0, 1], [1, 0], [0, -1], [-1, 0]].each do |c|

# end
