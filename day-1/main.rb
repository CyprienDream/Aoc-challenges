# part 1

file = File.open("input.txt")
numbers = file.readlines.map(&:chomp)
numbers.map!(&:to_i)


def get_num_increases(numbers)
  counter = 0
  numbers.each_with_index do |number, index|
    break if index == numbers.length - 1
    # puts numbers[index + 1]
    counter += 1 if number < numbers[index + 1]
  end
  counter
end

answer_1 = get_num_increases(numbers)

# part 2
sums_array = []

numbers.each_with_index do |number, index|
  break if index == numbers.length - 2

  sums_array << number + numbers[index + 1] + numbers[index + 2]
end

answer_2 = get_num_increases(sums_array)
p answer_2
