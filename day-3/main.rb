# This is a failed attempt at solving the problem

# read input file and split into array of lines
data = File.open("input.txt")
lines = data.readlines.map(&:chomp)

# initialise weight array
weights = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

# populate weights array
lines.each do |l|
  l.scan(/./).each_with_index do |char, index|
    weights[index] += 1 if char == '1'
  end
end

bin_g = []
bin_e = []
oxygen = []
carbon = []
counter = 0


# build indicative bit weight array for oxygen
oxygen = weights.map do |weight|
  if weight >= 500
    "1"
  else
    "0"
  end
end

# build indicative bit weight array for carbon
carbon = weights.map do |weight|
  if weight < 500
    "1"
  else
    "0"
  end
end

# store a copy of input file to be able to modify lines variable
lines_copy = lines

oxygen.each_with_index do |weight, index|
  break if lines.count('a') == 999 # stop loop if there is only one element left

  # bin_g << 1 if e > 500
  # bin_g << 0 if e < 500
  # bin_e << 0 if e > 500
  # bin_e << 1 if e < 500
  # break if lines.length == 2

  # puts "CRITERIA: #{weight}"
  lines.each_with_index do |line, i|
    break if lines.count('a') == 999 # break loop if there is only one element left

    line = line.scan(/./) # split line into array of characters
    # puts "current number: #{line}"
    # puts "current bit: #{line[index]}"
    # puts "the condition is #{line[index] == weight}"
    if line[index] != weight
      lines[i] = 'a' # replace element with 'a' if
      # p "lines[i]= " + lines[i].to_s
    end
    # puts "updated number: #{lines[i]}"
    # puts ""
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

# remove unwanted elements
lines.delete('a')
lines_copy.delete('a')

# format remaining element in each array
ox = lines[0].to_i(2)
ca = lines_copy[0].to_i(2)

# calculate result
result = ca * ox
p result

# gamma = bin_g.join.to_i(2)
# epsilon = bin_e.join.to_i(2)

# answer = gamma * epsilon
