# this method counts the number of times a number is bigger than the one at the position before it
def get_num_increases(numbers)
  counter = 0
  numbers.each_with_index do |number, index|
    break if index == numbers.length - 1 # leaves the loop in case there is no number after the current number

    counter += 1 if number < numbers[index + 1]
  end
  counter
end

# this method calculates the three number sum for each number in the array
def get_sums_array(numbers)
  sums_array = []

  numbers.each_with_index do |number, index|
    break if index == numbers.length - 2 # breaks loop if there are no more numbers available

    sums_array << number + numbers[index + 1] + numbers[index + 2]
  end
end

# read file and store data in integer array
file = File.open("input.txt")
numbers = file.readlines.map(&:chomp)
numbers.map!(&:to_i)

# part 1
answer_1 = get_num_increases(numbers)
p answer_1

# part 2
answer_2 = get_num_increases(get_sums_array(numbers))
p answer_2
