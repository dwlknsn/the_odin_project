require_relative "node"

class Tree
  attr_reader :arr, :root

  def initialize(arr = [])
    @arr = arr.uniq.sort
    @root = build_tree(@arr)
  end

  def build_tree(arr)
    # base case for recursion
    return nil if arr.length == 0
    return Node.new(data: arr[0]) if arr.length == 1

    mid_index = arr.length / 2

    left_arr = arr[0..(mid_index - 1)]
    right_arr = arr[(mid_index + 1)..]

    Node.new(
      data: arr[mid_index],
      left_child: build_tree(left_arr),
      right_child: build_tree(right_arr)
    )
  end

  def insert(value)
    # #insert method which accepts a value and adds a new node with that value in the correct location in the binary search tree.

    parent_node = root

    loop do
      break if parent_node.data == value # value already exists

      if value < parent_node.data
        child_node = parent_node.left_child
        if child_node.nil?
          parent_node.left_child = Node.new(data: value)
          break
        end
      else
        child_node = parent_node.right_child
        if child_node.nil?
          parent_node.right_child = Node.new(data: value)
          break
        end
      end

      parent_node = child_node
    end
  end

  def delete(root_node = root, value)
    # You’ll have to deal with several cases for delete, such as when a node has children or not.

    return if root_node.nil?

    if value < root_node.data
      root_node.left_child = delete(root_node.left_child, value)
      root_node
    elsif value > root_node.data
      root_node.right_child = delete(root_node.right_child, value)
      root_node
    else # we have found the node to be deleted

      if root_node.leaf? # node with no children
        nil
      elsif root_node.left_child.nil? # node with only right child
        root_node.right_child
      elsif root_node.right_child.nil? # node with only left child
        root_node.left_child
      else  # node with two children
        temp = min_value_node(root_node.right_child)
        root_node.data = temp.data
        root_node.right_child = delete(root_node.right_child, temp.data)
        root_node
      end
    end
  end

  def min_value_node(root_node)
    find(inorder(root_node).first)
  end

  def find(value)
    # #find method which accepts a value and returns the node with the given value.

    parent_node = root

    loop do
      break if parent_node.nil?
      break if parent_node.data == value

      parent_node = if value < parent_node.data
        parent_node.left_child
      else
        parent_node.right_child
      end
    end

    parent_node
  end

  def level_order(root_node = root)
    # Write a #level_order method which accepts a block. This method should traverse the tree in breadth-first level order and yield each node to the provided block. This method can be implemented using either iteration or recursion (try implementing both!). The method should return an array of values if no block is given. Tip: You will want to use an array acting as a queue to keep track of all the child nodes that you have yet to traverse, and to add new ones to the list (video on level order traversal).
    #
    #
    queue = [root_node]
    values = []

    loop do
      node = queue.shift
      break if node.nil?

      queue << node.left_child unless node.left_child.nil?
      queue << node.right_child unless node.right_child.nil?

      if block_given?
        yield node
      else
        values << node.data
      end
    end

    values unless block_given?
  end

  def inorder(node = root, values = [], &block)
    # inorder, #preorder, and #postorder methods that accepts a block. Each method should traverse the tree in their respective depth-first order and yield each node to the provided block. The methods should return an array of values if no block is given.

    return if node.nil?

    inorder(node.left_child, values, &block)

    if block
      yield node
    else
      values << node.data
    end

    inorder(node.right_child, values, &block)

    values.flatten.compact
  end

  def preorder(node = root, values = [], &block)
    # inorder, #preorder, and #postorder methods that accepts a block. Each method should traverse the tree in their respective depth-first order and yield each node to the provided block. The methods should return an array of values if no block is given.

    return if node.nil?

    if block
      yield node
    else
      values << node.data
    end

    preorder(node.left_child, values, &block)
    preorder(node.right_child, values, &block)

    values.flatten.compact
  end

  def postorder(node = root, values = [], &block)
    # inorder, #preorder, and #postorder methods that accepts a block. Each method should traverse the tree in their respective depth-first order and yield each node to the provided block. The methods should return an array of values if no block is given.

    return if node.nil?

    postorder(node.left_child, values, &block)
    postorder(node.right_child, values, &block)

    if block
      yield node
    else
      values << node.data
    end

    values.flatten.compact
  end

  def height(node)
    # height method that accepts a node and returns its height. Height is defined as the number of edges in longest path from a given node to a leaf node.

    return -1 if node.nil?

    [height(node.left_child), height(node.right_child)].max + 1
  end

  def depth(node)
    # Write a #depth method that accepts a node and returns its depth. Depth is defined as the number of edges in path from a given node to the tree’s root node.

    depth_count = 0
    parent_node = root

    loop do
      break if node.data.nil?
      break if node.data == parent_node.data

      depth_count += 1

      parent_node = if node.data < parent_node.data
        parent_node.left_child
      else
        parent_node.right_child
      end
    end

    depth_count
  end

  def balanced?
    # Write a #balanced? method that checks if the tree is balanced. A balanced tree is one where the difference between heights of left subtree and right subtree of every node is not more than 1.

    left_height = height(root.left_child)
    right_height = height(root.right_child)

    (left_height - right_height).between?(-1, 1)
  end

  def rebalance
    # Write a #rebalance method which rebalances an unbalanced tree. Tip: You’ll want to use a traversal method to provide a new array to the #build_tree method.

    @root = build_tree(inorder)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    # sleep 0.1
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end
end
