def parse_file
  lines = []
  File.open('test.txt').readlines.map(&:chomp).each do |line|
    lines << line.split('|')
  end
  lines
end

def is_letter_in_words?(words, letter)
  words.each do |word|
    bool &= word.include?(letter)
  end
  bool
end

line = parse_file
p line
string = line[0][0] + line[0][1]
p string

weights = Hash.new(0)
easy_nums = 0
string.split(" ").each do |word|
  weights[word.length] += 1
  easy_nums << word if [1, 4, 7, 8].include?(word.length)

end
p easy_nums





# p weights
# part_1 = weights[2] + weights[4] + weights[7] + weights[3]
# p part_1
