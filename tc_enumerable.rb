require "test/unit"

require "binarytree.rb"

class TestBinarytreeRb < Test::Unit::TestCase
  def test_enumerable
    tree = BinaryTree.new(40)
    tree.add(30)
    tree.add(50)
    puts tree.walk    
  end
end