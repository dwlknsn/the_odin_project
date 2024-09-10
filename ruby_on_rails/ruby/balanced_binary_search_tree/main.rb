# Tie it all together
# Write a driver script that does the following:

# Create a binary search tree from an array of random numbers (Array.new(15) { rand(1..100) })
# Confirm that the tree is balanced by calling #balanced?
# Print out all elements in level, pre, post, and in order
# Unbalance the tree by adding several numbers > 100
# Confirm that the tree is unbalanced by calling #balanced?
# Balance the tree by calling #rebalance
# Confirm that the tree is balanced by calling #balanced?
# Print out all elements in level, pre, post, and in order.

require_relative "lib/node"
require_relative "lib/tree"

# arr = Array.new(15) { rand(100) }
# arr = ("A".."K").to_a
arr = (1..15).to_a
tree = Tree.new(arr)
tree.pretty_print
puts "Balanced? #{tree.balanced?}"

[16, 17, 18].each { |num| puts "Inserting #{num}"; tree.insert(num) }
tree.pretty_print

puts "Deleting 18 (no children)"
tree.delete(18)
tree.pretty_print

puts "Deleting 15 (one child)"
tree.delete(15)
tree.pretty_print

puts "Deleting 8 (two children)"
tree.delete(8)
tree.pretty_print

x = []
tree.level_order { |node| x << node.data }
puts "Level-Order with block: #{x}"
puts "Level-Order without block: #{tree.level_order}"

x = []
tree.preorder { |node| x << node.data }
puts "Pre-Order with block: #{x}"
puts "Pre-Order without block: #{tree.preorder}"

x = []
tree.inorder { |node| x << node.data }
puts "In-Order with block: #{x}"
puts "In-Order without block: #{tree.inorder}"

x = []
tree.postorder { |node| x << node.data }
puts "Post-Order with block: #{x}"
puts "Post-Order without block: #{tree.postorder}"

[20, 21, 22].each { |num| puts "Inserting #{num}"; tree.insert(num) }
tree.pretty_print
puts "Balanced? #{tree.balanced?}"

node = tree.find(14)
puts "Height of 14: #{tree.height(node)}"
puts "Depth of 14: #{tree.depth(node)}"

node = tree.root
puts "Height of root: #{tree.height(node)}"
puts "Depth of root: #{tree.depth(node)}"

tree.inorder.sample(3).each do |n|
  puts "Find #{n}: #{tree.find(n).to_s}"
end

tree.rebalance
tree.pretty_print
puts "Balanced? #{tree.balanced?}"

puts "Level-Order without block: #{tree.level_order}"
puts "Pre-Order without block: #{tree.preorder}"
puts "In-Order without block: #{tree.inorder}"
puts "Post-Order without block: #{tree.postorder}"
