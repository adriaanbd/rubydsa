class Node
  attr_reader :data
  attr_accessor :left, :right

  def initialize(data)
    @data = data
    @left, @right = nil, nil
  end
end

def array_to_tree(array, idx = 0)
  return nil if idx >= array.size || array[idx].zero?

  node = Node.new(array[idx])

  node.left = array_to_tree(array, (2 * idx) + 1)
  node.right = array_to_tree(array, (2 * idx) + 2)

  node
end

def height(node)
  return false if node == false 
  if node.nil?
    return 0
  else
    left = height(node.left)
    right = height(node.right)
    difference = left - right
    return false if difference.abs > 1
    height = left >= right ? left + 1 : right + 1 
    height
  end
end

def balanced_tree?(array)
  root = array_to_tree(array)
  return true if height(root)
  false
end

puts balanced_tree?([1, 2, 0, 3, 4, 0, 0])
# => false

puts balanced_tree?([1, 2, 3, 4, 5, 6, 7])
# => true

puts balanced_tree?([1, 2, 0, 3, 4, 0, 0])
# => false

puts balanced_tree?([1, 2, 3, 4, 5, 6, 7])
# => true