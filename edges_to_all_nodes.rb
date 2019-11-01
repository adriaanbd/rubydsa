
# You're creating an app to navigate the train system and you're working on an option to find routes with the least stops. Given a graph of the train system, can you print the least number of station stops from Station 0 to all the Stations?

class Node 
  attr_accessor :stops
  attr_reader :station
  
  def initialize(station, stops=0)
    @station = station
    @stops = stops
  end
end

def weighted_graphs(matrix)
    start = Node.new(0)
    queue = []
    queue.prepend(start)
    seen_nodes = {start.station => start}
    stops = []

    while queue.size > 0
        current = queue.pop
        neighbors = matrix[current.station]
        neighbors.each_with_index do |path, station|
            seen = seen_nodes.fetch(station, nil)
            next if path.zero? || seen 
            node = Node.new(station, current.stops + 1)
            queue.prepend(node)
            seen_nodes[station] = node # and track node
        end
    end

    # get costs to all paths from start node
    (matrix.size).times do |i|
       min_stops = seen_nodes[i].stops
       stops << min_stops
    end
  return stops
end

p weighted_graphs([[0, 0, 1, 3, 0, 0], [0, 0, 0, 5, 0, 0], [1, 0, 0, 2, 1, 4], [3, 5, 2, 0, 7, 0], [0, 0, 1, 7, 0, 2], [0, 0, 4, 0, 2, 0]])
# => [0, 2, 1, 1, 2, 2]