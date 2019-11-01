class Node 
  attr_accessor :key, :cost, :parent
  
  def initialize(key, cost=0, parent=nil)
    @key = key
    @cost = cost
    @parent = parent
  end

  def <(other)
    @cost < other.cost 
  end

  def <=>(other)
    return @cost <=> other.cost 
  end
end

class PriorityQueue
  attr_accessor :queue 

  def initialize
    @queue = []
    @size = 0 
  end 

  def <<(item)
    @queue.prepend(item)
    @size += 1
  end

  def pop
    @queue.sort!
    @size -= 1
    @queue.delete_at(0)
  end

  def size
    @size
  end
end

def shortest_path(last_node)
  weights = []
  current = last_node.parent
  while current.parent
    weights << current.cost 
    current = current.parent
  end
  return weights
end

def shortest_path_wg(matrix)
  start = Node.new(0)
  frontier = PriorityQueue.new
  frontier << start
  explored = {}
  frontier_nodes = {}

  while frontier.size > 0
    current = frontier.pop
    p current
    neighbors = matrix[current.key]
    p neighbors

    neighbors.each_with_index do |cost, key|
        next if cost.zero?
        p "#{cost}, #{key}"
        path_cost = current.cost + cost
        node = Node.new(key, path_cost, current.key)

        visited = explored.fetch(key, nil)

        if visited 
            explored[key] = node if node < visited
            next
        end

        n = frontier_nodes.fetch(key, nil)
        if n && node <= n
            frontier_nodes[key] = node 
        else
            frontier << node
        end 
    end

    explored[current.key] = current
  end
  p explored
  return shortest_path(explored[5])
end

p shortest_path_wg([
  [0, 0, 1, 3, 0, 0], 
  [0, 0, 0, 5, 0, 0], 
  [1, 0, 0, 2, 1, 4], 
  [3, 5, 2, 0, 7, 0], 
  [0, 0, 1, 7, 0, 2], 
  [0, 0, 4, 0, 2, 0]
  ])
  
# => [0, 8, 1, 3, 2, 4]