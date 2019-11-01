class Node 
  attr_reader :edge
  attr_accessor :cost
  
  def initialize(edge, cost=0)
    @edge = edge
    @cost = cost
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
  end

  def pop
    @queue.sort!
    @queue.delete_at(0)
  end

  def size
    @size
  end
end

def minimum_spanning_tree(matrix)
  start = 0
  weights = []
  visited = Array.new(matrix.size - 1)
  visited[start] = true
  
  queue = PriorityQueue.new
  root = Node.new(start)
  queue << root
  q_nodes = {start => root}
  while queue
    current = queue.pop
    visited[current.edge] = true

    weights << current.cost unless current.edge.zero?
    break if weights.size == matrix.size - 1 # exit condition
    
    edges = matrix[current.edge] # get neighbors
    edges.each_with_index do |cost, edge| # iterate each neighbor
      explored = visited[edge] # has it been explored?
      qnode = q_nodes.fetch(edge, nil) # is it on the queue?
      next if cost.zero? || explored
      next if qnode && qnode.cost < cost

      if qnode.nil? # not on queue
        node = Node.new(edge, cost)
        queue << node # add to queue
        q_nodes[edge] = node # and track node
      else # on queue and has worse cost
        qnode.cost = cost # update cost
      end
    end
  end
  weights
end

p minimum_spanning_tree([
  [0, 4, 1, 4, 0, 0, 0, 0, 0, 0], # 0
  [4, 0, 5, 0, 9, 9, 0, 7, 0, 0], # 1
  [1, 5, 0, 3, 0, 0, 0, 9, 0, 0], # 2
  [4, 0, 3, 0, 0, 0, 0, 10, 0, 18], 
  [0, 9, 0, 0, 0, 2, 4, 0, 6, 0], # 4
  [0, 9, 0, 0, 2, 0, 2, 8, 0, 0], # 5
  [0, 0, 0, 0, 4, 2, 0, 9, 3, 9], # 6
  [0, 7, 9, 10, 0, 8, 9, 0, 0, 8],# 7
  [0, 0, 0, 0, 6, 0, 3, 0, 0, 9], # 8
  [0, 0, 0, 18, 0, 0, 9, 8, 9, 0] # 9
  ])
# => [1, 3, 4, 7, 8, 2, 2, 3, 8]

p minimum_spanning_tree([[0, 0, 1, 3, 0, 0], [0, 0, 0, 5, 0, 0], [1, 0, 0, 2, 1, 4], [3, 5, 2, 0, 7, 0], [0, 0, 1, 7, 0, 2], [0, 0, 4, 0, 2, 0]])
# => [1, 1, 2, 2, 5]