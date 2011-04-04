$: << File.expand_path(File.dirname(__FILE__) + "/../lib")
require "test/unit"
require "binarytree"
require "binarytreedrawer"

a = [ "a", "b", "c"]
a.each do |v|
  puts v
end

return

tree = BinaryTree.new("A")
puts tree.to_s

drawer = BinaryTreeDrawer.new(tree)
drawer.draw(0,0, Proc.new { |value, x, y, px, py| 
  puts "Value #{value} at (#{x}, #{y})"
})
