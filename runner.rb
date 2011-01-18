require "binarytree.rb"

tree = BinaryTree.new(40)
tree.add(30)
tree.add(100)
tree.add(20)
tree.add(35)
tree.add(25)
tree.add(34)

puts "Tree nodes: #{tree.walk}"
puts "Tree height: #{tree.height}"
puts "Done"
