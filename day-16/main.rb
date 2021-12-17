 data = open("input.txt").read.chars.map{sprintf('%04b', _1.to_i(16))}.join("")

 def parse_literal(str)
  output = ""
  counter = 0
  str.chars.each_slice(5) do |group|
    output << group[1..4].join("")
    counter += 1
    break if group[0] == "0"
  end
  return {version_sum: 0, value: output.to_i(2), remainder: str[5 * counter..]}
end

def parse_packet(str)
  version = str.slice!(0, 3).to_i(2)
  id = str.slice!(0, 3).to_i(2)
  if id == 4
    result = parse_literal(str)
  else
    mode = str.slice!(0) == "0" ? "bits" : "subpackets"
    num_of_bits_or_subpackets = mode == "bits" ? str.slice!(0, 15).to_i(2) : str.slice!(0, 11).to_i(2)
    result = parse_several_packets(str: str, code: id, count: num_of_bits_or_subpackets, method: mode)
  end
  return {version_sum: version + result[:version_sum], value: result[:value], remainder: result[:remainder]}
end

def parse_several_packets(str:, code:, count:, method:)
  versions = []
  values = []
  if method == "subpackets"
    count.times do
      result = parse_packet(str)
      versions << result[:version_sum]
      values << result[:value]
      str = result[:remainder]
    end
  else # Known number of bits
    part = str.slice!(0, count)
    until part.empty? do
      result = parse_packet(part)
      versions << result[:version_sum]
      values << result[:value]
      part = result[:remainder]
    end
  end
  case code
  when 0 then value = values.sum
  when 1 then value = values.reduce(&:*)
  when 2 then value = values.min
  when 3 then value = values.max
  when 5 then value = values[0] > values[1] ? 1 : 0
  when 6 then value = values[0] < values[1] ? 1 : 0
  when 7 then value = values[1] == values[0] ? 1 : 0
  end
  return {version_sum: versions.sum, value: value, remainder: str}
end

p parse_packet(data)
