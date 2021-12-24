file = File.open("input.txt")
input = file.readlines

class Scalar
  def initialize(value)
    self.value = value
  end

  attr_accessor :value

  def magnitude
    value
  end

  def add_scalar_left(scalar)
    self.value += scalar.value
  end

  def add_scalar_right(scalar)
    self.value += scalar.value
  end

  def explode(_)
    nil
  end

  def split
    if value >= 10
      half = value / 2
      Pair.new(Scalar.new(half), Scalar.new(value - half))
    else
      nil
    end
  end

  def to_s
    value.to_s
  end
end

class Pair
  def initialize(left, right)
    self.left = left
    self.right = right
  end

  attr_accessor :left, :right

  def magnitude
    3 * left.magnitude + 2 * right.magnitude
  end

  def +(other)
    Pair.new(self, other)
  end

  def to_s
    "[#{left.to_s},#{right.to_s}]"
  end

  def reduce
    while true
      next if explode(0)
      next if split
      break
    end

    self
  end

  protected

  def split
    left_split = left.split
    if left_split
      self.left = left_split
      return self
    end

    right_split = right.split
    if right_split
      self.right = right_split
      return self
    end

    nil
  end

  def explode(depth)
    return self if depth > 3

    result = left.explode(depth + 1)

    if result
      # binding.pry
      # Left needs to explode, try adding the scalar to the right
      self.left = Scalar.new(0) if depth == 3
      self.right.add_scalar_left(result.right)

      # This value needs to propagate
      return Pair.new(result.left, Scalar.new(0))
    end

    result = right.explode(depth + 1)

    if result
      # binding.pry
      # Right needs to explode, try adding the scalar to the left
      self.left.add_scalar_right(result.left)
      self.right = Scalar.new(0) if depth == 3

      # This value needs to propagate
      return Pair.new(Scalar.new(0), result.right)
    end

    nil
  end

  def add_scalar_left(scalar)
    self.left.add_scalar_left(scalar)
  end

  def add_scalar_right(scalar)
    self.right.add_scalar_right(scalar)
  end
end

class Parser
  def self.parse(string)
    if string.to_i.to_s == string
      Scalar.new(string.to_i)
    elsif string.start_with?('[') && string.end_with?(']')
      sub_string = string[1..-2]
      bracket_count = 0
      comma_index = sub_string.chars.find_index do |c|
        next true if bracket_count == 0 && c == ','

        bracket_count += 1 if c == '['
        bracket_count -= 1 if c == ']'
        false
      end
      left_string = sub_string[0...comma_index]
      right_string = sub_string[comma_index+1..-1]

      Pair.new(Parser.parse(left_string), Parser.parse(right_string))
    else
      raise ArgumentError, 'Bad string'
    end
  end
end

running_total = nil
input.each do |line|
  parsed = Parser.parse(line.strip)
  if running_total.nil?
    running_total = parsed
  else
    running_total += parsed
  end
  running_total.reduce
end

puts "Part One: #{running_total.magnitude}"

lines = input.map { |line| line.strip }
max_magnitude = 0

(0...lines.length).each do |i|
  (0...lines.length).each do |j|
    next if i == j
    result = (Parser.parse(lines[i]) + Parser.parse(lines[j])).reduce
    magnitude = result.magnitude
    max_magnitude = magnitude if magnitude > max_magnitude
  end
end

puts "Part Two: #{max_magnitude}"
