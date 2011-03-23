#!/usr/bin/env ruby

# Creates a small binary tree and displays on the console 
# the coordinates where its nodes should be drawn. This 
# program does not draw the tree.

$: << File.expand_path(File.dirname(__FILE__) + "/../lib")
require "binarytree"
require "binarytreedrawer"

tree = BinaryTree.new
tree.add(100)
tree.add(50)
tree.add(150)
tree.add(25)
tree.add(75)
tree.add(125)
tree.add(175)

drawer = BinaryTreeDrawer.new(tree)
drawer.draw(0,0, Proc.new { |value, x, y, px, py| 
  puts "Value #{value} at (#{x}, #{y})"
})

