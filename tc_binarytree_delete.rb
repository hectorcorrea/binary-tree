require "test/unit"
require "binarytree.rb"  

class TestBinaryTree < Test::Unit::TestCase

def test_delete_leaf_node
	tree = setup_tree_for_delete()
	total_nodes = tree.total_nodes
	tree.delete(25)
	assert_equal("20, 30, 34, 35, 40, 100", tree.to_s)		
	tree.delete(34)
	assert_equal("20, 30, 35, 40, 100", tree.to_s)		
	tree.delete(35)
	assert_equal("20, 30, 40, 100", tree.to_s)
	assert_equal(total_nodes-3, tree.total_nodes)		
end

def test_delete_single_child_node
	tree = setup_tree_for_delete()
	total_nodes = tree.total_nodes
	tree.delete(20)
	assert_equal("25, 30, 34, 35, 40, 100", tree.to_s)		
	tree.delete(35)
	assert_equal("25, 30, 34, 40, 100", tree.to_s)
	assert_equal(total_nodes-2, tree.total_nodes)	  		
end

def test_delete_two_children_node
	tree = setup_tree_for_delete()
	total_nodes = tree.total_nodes
	tree.delete(30)
	assert_equal("20, 25, 34, 35, 40, 100", tree.to_s)		
	assert_equal(total_nodes-1, tree.total_nodes)
end

def test_delete_root_leaf
	tree = BinaryTree.new(40)
	tree.delete(40)
	assert_equal(0, tree.total_nodes)
	assert_equal(nil, tree.root)
end

def test_delete_root_one_child_left
	tree = BinaryTree.new(40)
	tree.add(100)
	tree.delete(40)
	assert_equal(1, tree.total_nodes)
	assert_equal(100, tree.root.value)
end

def test_delete_root_one_child_right
	tree = BinaryTree.new(40)
	tree.add(30)
	tree.delete(40)
	assert_equal(1, tree.total_nodes)
	assert_equal(30, tree.root.value)
end

def test_delete_root_one_child_right2
	tree = BinaryTree.new(40)
	tree.add(40)
	tree.delete(40)
	assert_equal(1, tree.total_nodes)
	assert_equal(40, tree.root.value)
end

def test_delete_root_two_children
	tree = BinaryTree.new(40)
	tree.add(30)
	tree.add(100)
	tree.delete(40)
	assert_equal(2, tree.total_nodes)
	assert_equal(100, tree.root.value)
end

def test_delete_root_two_children_full_tree
	tree = setup_tree_for_delete()
	total_nodes = tree.total_nodes
	tree.delete(tree.root.value)
	assert_equal(total_nodes-1, tree.total_nodes)
end

def test_empty_tree_after_delete
	tree = BinaryTree.new(40)
	assert_equal(false, tree.is_empty?)
	tree.delete(40)
	assert_equal(true, tree.is_empty?)
end

def setup_tree_for_delete
	tree = BinaryTree.new(40)
	tree.add(30)
	tree.add(100)
	tree.add(20)
	tree.add(35)
	tree.add(25)
	tree.add(34)
	return tree
end

end
