# store input into hash with cave as keys and array of adjacent caves as values
cavemap = Hash.new{|h,k|h[k]=[]}
input = File.open('input.txt').read.split.each do |line|
    a, b = line.split('-')
    cavemap[a] << b
    cavemap[b] << a
end

# returns true if the cave is small
def small?(cave)
  cave.match?(/^[a-z]+/)
end

# this method uses recursion to calculate the number of possible paths
def countpaths(graph, doubled, visited, from, to)
  # add 1 to total whenever end cave is reached
  return 1 if from == to
  # skips to next path if cave is small and has already been visited (part 1) or if the cave is start (part 2)
  if visited.include?(from)
    return 0 if doubled || from == 'start'
    doubled = true
  end
  # iterate through the array of adjacent caves of all the adjacent caves of start adn sum up the result
  graph[from].sum do |dest|
    countpaths(graph, doubled, small?(from) ? visited + [from] : visited, dest, to)
  end
end

# Part 1
puts countpaths(cavemap, true, [], 'start', 'end')

# Part 2
puts countpaths(cavemap, false, [], 'start', 'end')

# hi
