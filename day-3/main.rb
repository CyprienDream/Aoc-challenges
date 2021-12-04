data = File.open("input.txt")

# line_number = data.readlines.count

weights = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

lines = data.readlines.map(&:chomp)

lines.each do |l|
  l.scan(/./).each_with_index do |char, index|
    weights[index] += 1 if char == '1'
  end
end
p weights

bin_g = []
bin_e = []
oxygen = []
carbon = []
counter = 0


# oxygen
oxygen = weights.map do |weight|
  if weight >= 500
    "1"
  else
    "0"
  end
end

carbon = weights.map do |weight|
  if weight < 500
    "1"
  else
    "0"
  end
end
p oxygen
p carbon

lines_copy = lines

oxygen.each_with_index do |weight, index|
  break if lines.count('a') == 999

  # bin_g << 1 if e > 500
  # bin_g << 0 if e < 500
  # bin_e << 0 if e > 500
  # bin_e << 1 if e < 500
  # break if lines.length == 2

  puts "CRITERIA: #{weight}"
  lines.each_with_index do |line, i|
    break if lines.count('a') == 999

    line = line.scan(/./)
    puts "current number: #{line}"
    puts "current bit: #{line[index]}"
    puts "the condition is #{line[index] == weight}"
    if line[index] != weight
      lines[i] = 'a'
      # p "lines[i]= " + lines[i].to_s
    end
    puts "updated number: #{lines[i]}"
    puts ""
    # p line
    # if e > 500
    #   oxygen << l if l[0] == '1'
    #   co2 << l if l[0] == '0'
    # elsif e < 500
    #   oxygen << l if l[0] == '0'
    #   co2 << l if l[0] == '1'
    # else
    #   oxygen << l if l[0] == '1'
    #   co2 << l if l[0] == '0'
    # end

    # bit = e >= 500 ? '1' : '0'
    # lines[i] = 0 unless l[index] == bit

    # p "line[index]= " + line[index].to_s
    # p "lines[i]= " + lines[i].to_s
    # p "condition is #{line[index] == weight}"
    # p line[index] == bit
    # p line[index].class
    # p weight.class


    # if (e >= 500) && l[index] == '0'
    #   lines.delete_at(i)
    #   counter += 1
    # elsif e < 500 && l[index] == '1'
    #   lines.delete_at(i)
    #   counter += 1
    # end
    # p "#{bit}-#{l[index]}"
  end
end

carbon.each_with_index do |weight, index|
  break if lines_copy.count('a') == 999

  lines_copy.each_with_index do |line, i|
    break if lines_copy.count('a') == 999

    line = line.scan(/./)

    if line[index] != weight
      lines_copy[i] = 'a'
    end
  end
end

# puts counter
lines.delete('a')
lines_copy.delete('a')
ox = lines[0].to_i(2)
ca = lines_copy[0].to_i(2)
p ox
p ca

result = ca * ox

p result
# gamma = bin_g.join.to_i(2)
# epsilon = bin_e.join.to_i(2)

# answer = gamma * epsilon
