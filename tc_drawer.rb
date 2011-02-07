require "test/unit"
require "binarytree"
require "binarytreedrawer"

class TestBinaryTreeDrawer < Test::Unit::TestCase

  def test_empty_tree
    tree = BinaryTree.new
    drawer = BinaryTreeDrawer.new(tree, 10, 10)
    empty = true
    drawer.draw(0, 0, Proc.new { |value, x, y, px, py| empty = false})
    assert_equal(true, empty)
  end

  def test_root_only
    tree = BinaryTree.new(40)
    drawer = BinaryTreeDrawer.new(tree, 10, 10)
    empty = true
    root_x = -1
    root_y = -1
    drawer.draw(0, 0 , Proc.new { |value, x, y, px, py| 
        empty = false
        root_x = x
        root_y = y})
    assert_equal(false, empty)
    assert_equal(root_x, 0)
    assert_equal(root_y, 0)
  end

  def test_tree_nodes
    tree = BinaryTree.new(40)
    tree.add(30)
    tree.add(100)
    drawer = BinaryTreeDrawer.new(tree, 10, 10)

    point = Struct.new(:x, :y, :value)
    nodes = []
    drawer.draw(0, 0, Proc.new { |value, x, y, px, py| 
        nodes << point.new(x, y, value) })

    assert_equal(3, nodes.length)
        
    assert_equal(0, nodes[0].x)
    assert_equal(0, nodes[0].y)
    assert_equal(40, nodes[0].value)

    assert_equal(-10, nodes[1].x)
    assert_equal(10, nodes[1].y)
    assert_equal(30, nodes[1].value)

    assert_equal(10, nodes[2].x)
    assert_equal(10, nodes[2].y)
    assert_equal(100, nodes[2].value)        
  end
  
  def test_random_tree
    
    tree = BinaryTree.new()
    test_vales = "1000, 500, 2000, "
    tree.add(1000)
    tree.add(500)
    tree.add(2000)
    20.times do 
      new_node = rand(10000) 
      tree.add(new_node)
      test_vales += ", " + new_node.to_s
    end

    drawer = BinaryTreeDrawer.new(tree, 10, 10)
    root_x, root_y = 0, 0 
    drawer.draw(0, 0, Proc.new { |value, x, y, px, py| 
      
        is_root = (x == px && y = py)
        is_greater_than_root = (value > 1000) 
        
        if is_root
          root_x, root_y = x, y
          assert_equal(0, x)
          assert_equal(0, y)
        else
          if is_greater_than_root
            assert( x > root_x, "Greater than failed for node #{value} (x=#{x}) Tree: #{test_vales}")
          else
            assert( x < root_x, "Less than failed for node #{value} (x=#{x}) Tree: #{test_vales}")
          end
          
        end
        
    })
      
  end

end