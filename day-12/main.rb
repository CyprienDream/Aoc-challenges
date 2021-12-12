cavemap = Hash.new{|h,k|h[k]=[]}
input = File.open('input.txt').read.split.each do |line|
    a, b = line.split('-')
    cavemap[a] << b
    cavemap[b] << a
end

def small?(cave) = cave.match?(/^[a-z]+/)

def countpaths(graph, doubled, visited, from, to)
    return 1 if from == to
    if visited.include?(from)
        return 0 if doubled || from == 'start'
        doubled = true
    end
    graph[from].sum do |dest|
        countpaths(graph, doubled, small?(from) ? visited + [from] : visited, dest, to)
    end
end

# Part 1
puts countpaths(cavemap, true, [], 'start', 'end')

# Part 2
puts countpaths(cavemap, false, [], 'start', 'end')
