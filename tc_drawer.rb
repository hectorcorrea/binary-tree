require "test/unit"
require "binarytree"
require "binarytreedrawer"

class TestBinaryTreeDrawer < Test::Unit::TestCase

  def test_draw
    tree = setup_tree2
    drawer = BinaryTreeDrawer.new(tree)
    drawer.draw(100,10, Proc.new { |value, x,y, px, py| 
      puts "draw_circle(#{x}, #{y}); // #{value}" 
      #puts "draw_line( #{x}, #{y}, #{px}, #{py})"
      #puts 
      })
  end

  def setup_tree2
    tree = BinaryTree.new
    tree.add(5175)
    tree.add(228)
    tree.add(2486)
    tree.add(1364)
    tree.add(3627)
    tree.add(2562)
    tree.add(9175)
    tree.add(6261)
    tree.add(8437)
    tree.add(9685) 
    return tree   
  end
  
  def setup_tree3
    tree = BinaryTree.new
    tree.add(51)
    tree.add(2)
    tree.add(24)
    tree.add(13)
    tree.add(36)
    tree.add(25)
    tree.add(91)
    tree.add(62)
    tree.add(84)
    tree.add(96) 
    return tree   
  end

  def setup_tree
    tree = BinaryTree.new
    tree.add(40)
    tree.add(30)
    tree.add(100)
    tree.add(35)
    #tree.add(34)
    #tree.add(36)
    #tree.add(37)
    #tree.add(38)
    #tree.add(39)
    return tree
  end

end