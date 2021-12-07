def parse_file
  File.open('input.txt').readlines.map(&:chomp)[0].split(',').map(&:to_i)
end

numbers = parse_file
max = numbers.max
p max
sums = []

for i in 0..max
  sums[i] = numbers.map { |num| (0..(num - i).abs).sum }.sum
  p i
end

p sums.min

# p part_1

# sum = numbers.sum


# numbers.each do  |num|
#   current /= numbers.count
#   min_dist = numbers[current..numbers.count]
# end
