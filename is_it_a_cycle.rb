# dfs using stack, naive approach
def graph_cycle?(graph, source=nil)
  frontier = [graph.keys.first]
  visited = []
  while frontier
    break if frontier.empty? 
    current = frontier.pop
    neighbors = graph.fetch(current, nil)
    next if neighbors.nil?
    neighbors.each do |neighbor|
      frontier << neighbor unless visited.include?(neighbor)
    end
    visited << current
  end

  visited.uniq != visited
end

puts graph_cycle?({
  0=>[2], 
  1=>[4], 
  2=>[0, 5, 3], 
  3=>[5, 2], 
  4=>[5, 1], 
  5=>[4, 2, 3]
})
# => true

puts graph_cycle?({
  0=>[2], 
  1=>[2], 
  2=>[0, 1, 3, 4, 5], 
  3=>[2], 
  4=>[2]
})
# => false

puts graph_cycle?({
  0=>[1], 
  1=>[3, 4], 
  2=>[5, 6], 
  3=>[7, 8]
})

#=> false