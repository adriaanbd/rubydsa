def graph_cycle?(graph, source=nil)
  nodes = []
  keys = graph.keys 
  keys.each do |key|
    nodes += graph[key]
  end

  nodes.uniq != nodes
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
# => true

puts graph_cycle?({
  0=>[1], 
  1=>[3, 4], 
  2=>[5, 6], 
  3=>[7, 8]
})

#=> false