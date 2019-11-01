# You will be given an array of numbers as input. Insert the numbers (in order) one-at-a-time into a binary search tree. Then return a string with the tree in pre-order 

class Node 
  attr_reader :value
  attr_accessor :left, :right
  
  def initialize(value, left=nil, right=nil)
      @value = value 
      @left = left 
      @right = right
  end
end

class BinarySearchTree 
  attr_reader :root

  def initialize(value)
    @root = Node.new(value)
  end

  def insert(value, node)
    if node.left.nil? && value <= node.value
      node.left = Node.new(value)
    elsif node.right.nil? && value > node.value
      node.right = Node.new(value)
    elsif node.left && value <= node.value
      insert(value, node.left) 
    elsif node.right && value > node.value
      insert(value, node.right)
    end
  end
end

def pre_order(root)
  if root.nil?
    return []
  else root
    array = [root.value]
    array += pre_order(root.left)
    array += pre_order(root.right)
  end
  array
end

def binary_search_tree(array)
  tree = BinarySearchTree.new(array.shift)
  while true
    break if array.empty?
    tree.insert(array.shift, tree.root)
  end
  pre_order(tree.root)
end

expected = [8, 3, 1, 6, 4, 7, 10, 14, 13]
puts binary_search_tree([8, 3, 10, 1, 6, 14, 4, 7, 13]) == expected
puts binary_search_tree([8, 3, 10, 1, 6, 14, 4, 7, 13]) == [8, 3, 1, 6, 4, 7, 10, 14, 13]
puts binary_search_tree([5, 3, 7, 1, 2, 6, 8]) == [5, 3, 1, 2, 7, 6, 8]
puts binary_search_tree([10, 12, 15, 7, 2, 23, 9, 14, 21]) == [10, 7, 2, 9, 12, 15, 14, 23, 21]
puts binary_search_tree([50, 25, 75, 15, 21, 62, 91]) == [50, 25, 15, 21, 75, 62, 91]
