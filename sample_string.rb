require "binarytree.rb"

tree = BinaryTree.new("HELLO")
tree.add("GOODBYE")
tree.add("HOLA")
tree.add("ADIOS")

puts "Tree nodes: #{tree.to_s}"
puts "Tree height: #{tree.height}"
puts "Done"
