def parse_file
  File.open('input.txt').readlines.map(&:chomp).map(&:to_i)
end

p parse_file
