#!/usr/bin/env ruby

# Sample of using the binary tree class with string values
require "binarytree.rb"

tree = BinaryTree.new("HELLO")
tree.add("GOODBYE")
tree.add("HOLA")
tree.add("ADIOS")

puts "Tree nodes: #{tree.to_s}"
puts "Tree height: #{tree.height}"
puts "Done"
