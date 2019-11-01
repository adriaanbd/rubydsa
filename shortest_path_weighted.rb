class Node 
  attr_accessor :key, :cost, :parent
  
  def initialize(key, cost=0, parent=nil)
    @key = key
    @cost = cost
    @parent = parent
  end

  def >(other)
    @cost > other.cost
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
    node = @queue.delete_at(0)
    @size -= 1
    node
  end

  def size
    @size
  end
end

def shortest_path_wg(matrix)
    start = Node.new(0)
    frontier = PriorityQueue.new
    frontier << start
    explored = {}
    frontier_nodes = {start.key => start}
    costs = []

    while frontier.size > 0
        current = frontier.pop
        neighbors = matrix[current.key]
        neighbors.each_with_index do |cost, key|
            next if cost.zero?
            path_cost = current.cost + cost
            node = Node.new(key, path_cost, current)


            visited = explored.fetch(key, nil) # check explored
            explored[key] = node if visited && visited > node # shorter
            next if visited # skip if visited

            n = frontier_nodes.fetch(key, nil) # check frontier
            frontier_nodes[key] = node if n && n > node # shorter
            next if n # skip if already on frontier
            frontier << node # else add to frontier
            frontier_nodes[key] = node # and track node
        end

        explored[current.key] = current

    end

    # get costs to all paths from start node
    (matrix.size).times do |i|
       cost = frontier_nodes[i].cost
       costs << cost
    end
  return costs
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