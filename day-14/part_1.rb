data = File.open('input.txt').readlines.map(&:chomp)
input = data[0]
instructions = {}

data[2..].each do |line|

  instructions[line.split('->')[0].strip] = line.split('->')[1].strip
end

p input


10.times do
  input.scan(/./).each_with_index do |char, i|
    if i != input.scan(/./).length - 1 && instructions.key?(char + input[i + 1])
      puts char
      puts "hey"
    end
  end
end
