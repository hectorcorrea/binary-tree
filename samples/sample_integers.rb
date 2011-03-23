#!/usr/bin/env ruby

# Sample of using the binary tree class with integer values

$: << File.expand_path(File.dirname(__FILE__) + "/../lib")
require "binarytree"

tree = BinaryTree.new(40)
tree.add(30)
tree.add(100)
tree.add(20)
tree.add(35)
tree.add(25)
tree.add(34)

puts "Tree nodes: #{tree.to_s}"
puts "Tree height: #{tree.height}"

puts "Looking for node with value 30..."
node = tree.find {|v| v.value == 30}
puts "we found it" if node != nil
puts "oops, we didn't find it" if node == nil

puts "Deleteing node with value 30..."
tree.delete(30)
puts "Looking for node with value 30..."
node = tree.find {|v| v.value == 30}
puts "oops! we found it" if node != nil
puts "great, we didn't find it" if node == nil

puts "Done"
