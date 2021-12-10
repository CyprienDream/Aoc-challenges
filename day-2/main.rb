# read input file and split into array of lines
data = File.open("input.txt")

# initialise variables
x = 0
depth = 0
aim = 0

data.readlines.map(&:chomp).each do |line|
  if line.include?("forward")
    x += line[-1].to_i
    depth += line[-1].to_i * aim
  end
  if line.include?("down")
    # depth += line[-1].to_i
    aim += line[-1].to_i
  end
  if line.include?("up")
    # depth -= line[-1].to_i
    aim -= line[-1].to_i
  end
  p line[-1].to_i
end

answer = x * depth

p answer
