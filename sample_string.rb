#!/usr/bin/env ruby

# Sample of using the binary tree class with string values
require "binarytree.rb"

tree = BinaryTree.new("AAA")
tree.add("CCC")
tree.add("DDD")
tree.add("BBB")

puts "Tree nodes: #{tree.to_s}"
puts "Tree height: #{tree.height}"
puts "Done"
