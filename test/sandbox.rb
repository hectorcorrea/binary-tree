$: << File.expand_path(File.dirname(__FILE__) + "/../lib")
require "test/unit"
require "binarytree"

tree = BinaryTree.new(100)
tree.add(50)
tree.add(150)
#puts tree.min.value
tree.xxx