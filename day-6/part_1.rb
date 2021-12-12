# split file into array of integers
def parse_file
  File.open('input.txt').readlines.map(&:chomp)[0].split(',').map(&:to_i)
end

# returns number of occurences of given element
def count_elements(array, element)
  buffer = Hash.new(0)

  array.each do |e|
    buffer[e] += 1
  end
  buffer[element]
end

numbers = parse_file


# main loop
80.times do
  # count number of zeroes
  num_0 = count_elements(numbers, 0)
  # remove zeroes
  numbers.delete_if {|number| number == 0}
  # substract 1 from each element
  numbers = numbers.map { |number| number - 1}

  # add 8 and 6 as many times as there were zeroes
  num_0.times do
    numbers << 8
    numbers << 6
  end
  # numbers.each_with_index do |fish, index|
  #   if fish == 0
  #     buffer << 8
  #     numbers[index] = 6
  #   else
  #     numbers[index] -= 1
  #   end
  # end
  # p buffer[0]
  # numbers = numbers + buffer
  p numbers.count
end
