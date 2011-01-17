require "test/unit"
require "binarytree.rb"  

class TestBinaryTree < Test::Unit::TestCase

	def test_root_only
		tree = BinaryTree.new(40)
		assert_equal(0, tree.height)
	end

	def test_one_child
		tree = BinaryTree.new(40)
		tree.add(30)
		assert_equal(1, tree.height)
	end
	
	def test_two_children_height_one
		tree = BinaryTree.new(40)
		tree.add(30)
		tree.add(50)  
		assert_equal(1, tree.height)
	end
	
	def test_two_children_height_two
		tree = BinaryTree.new(40)
		tree.add(30)
		tree.add(35)  
		assert_equal(2, tree.height)
	end
	
	def test_height_five
	  tree = BinaryTree.new(40)
  	tree.add(30)
  	tree.add(100)
  	tree.add(20)
  	tree.add(35)
  	tree.add(25)
  	tree.add(34)
  	tree.add(24)
  	tree.add(23)
  	assert_equal(5, tree.height)
  end
  
  
  
end
