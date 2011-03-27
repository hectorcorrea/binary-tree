$: << File.expand_path(File.dirname(__FILE__) + "/../lib")
require "test/unit"
require "binarytree"  

class TestBinaryTree < Test::Unit::TestCase

	def test_empty_tree	
		tree = BinaryTree.new
		assert_equal(true, tree.is_empty?)
	end
	
	def test_one_node_tree
		tree = BinaryTree.new(4)
		assert_equal(1, tree.total_nodes)
	end
	
	def test_three_node_tree
		tree = BinaryTree.new(4)
		tree.add(10)
		tree.add(7)
		assert_equal(3, tree.total_nodes)
	end
	
	def test_search_on_empty_tree
		tree = BinaryTree.new
		node = tree.search(3)
		assert_equal(nil, node)
	end
	
	def test_search_found
		tree = BinaryTree.new(3)
		node = tree.search(3)
		assert_equal(3, node.value)
	end
	
	def test_search_not_found
		tree = BinaryTree.new(3)
		node = tree.search(0)
		assert_equal(nil, node)
	end
	
	def test_walk_empty_tree
		tree = BinaryTree.new
		assert_equal("", tree.to_s)
	end
	
	def test_walk_one_node
		tree = BinaryTree.new(99)
		assert_equal("99", tree.to_s)
	end

	def test_walk_numbers
		tree = BinaryTree.new(40)
		tree.add(100)
		tree.add(30)
		tree.add(100)
		tree.add(99)
		tree.add(101)
		tree.add(25.6)
		tree.add(25.7)
		tree.add(20)
		tree.add(35)
		tree.add(1)
		tree.add(25)
		tree.add(150)
		tree.add(125)
		tree.add(55)
		assert_equal("1, 20, 25, 25.6, 25.7, 30, 35, 40, 55, 99, 100, 100, 101, 125, 150", tree.to_s)
	end
	
	def test_walk_strings
		tree = BinaryTree.new("THE")
		tree.add("QUICK")
		tree.add("BROWN")
		tree.add("FOX")
		tree.add("JUMPS")
		tree.add("THE")
		tree.add("LAZY")
		tree.add("DOG")	
    assert_equal("BROWN, DOG, FOX, JUMPS, LAZY, QUICK, THE, THE", tree.to_s)
	end
	
	def test_find_min_and_max
		tree = BinaryTree.new(40)
		tree.add(30)
		tree.add(100)
		tree.add(20)
		tree.add(35)
		tree.add(25)
		tree.add(34)
		assert_equal(20, tree.min.value)
		assert_equal(100, tree.max.value)
	end	
	
	def test_find_min_and_max_from_node
		tree = BinaryTree.new(40)
		tree.add(30)
		tree.add(50)
		tree.add(45)
		tree.add(100)
		tree.add(20)
		tree.add(35)
		tree.add(25)
		tree.add(34)
		start_node = tree.search(50)
		assert_equal(50, start_node.value)		
		assert_equal(45, tree.find_min_from_node(start_node).value)
		assert_equal(100, tree.find_max_from_node(start_node).value)			 
	end
	
	def test_walk_pre_order
  	tree = BinaryTree.new(40)
  	tree.add(30)
  	tree.add(100)
  	assert_equal("40, 30, 100", tree.to_s_pre_order)
  	tree.add(25)
  	tree.add(35)
  	tree.add(60)
  	tree.add(110)
  	assert_equal("40, 30, 25, 35, 100, 60, 110", tree.to_s_pre_order)		
  end

  def test_walk_post_order
  	tree = BinaryTree.new(40)
  	tree.add(30)
  	tree.add(100)
  	tree.add(25)
  	tree.add(35)
  	tree.add(60)
  	tree.add(110)
  	assert_equal("25, 35, 30, 60, 110, 100, 40", tree.to_s_post_order)		
  end
  
  def test_search_path
    tree = BinaryTree.new(40)
  	tree.add(30)
  	tree.add(100)
  	tree.add(25)
  	tree.add(35)
  	tree.add(60)
  	tree.add(110)
    
    # search value to the right of the root
  	values = []
  	tree.search(60) { |n| values << n.value }
  	assert_equal("40, 100, 60", values.join(", "))

    # search value to the left of the root
  	values = []
  	tree.search(35) { |n| values << n.value }
  	assert_equal("40, 30, 35", values.join(", "))
  end
  
  
		
end
