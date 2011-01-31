require "binarytree"

class BinaryTreeDrawer

  def initialize(tree)
    @tree = tree
    @x_distance = 20
    @y_distance = 30
  end  
  
  def draw(x, y, block)
    draw_node(@tree.root, x, y, block)
  end

  def draw_node(node, x, y, block)
    block.call(node.value,x,y,x,y)
    draw_left(node.left, x, y, block) if node.left != nil
    draw_right(node.right, x, y, block) if node.right != nil
  end
  
  def draw_left(node, parent_x, parent_y, block)
    if node.right != nil
      count = 1 + children_count(node.right)
    else
      count = 0
    end
    x = parent_x - @x_distance - (count*@x_distance)
    y = parent_y + @y_distance
    block.call(node.value,x,y,parent_x, parent_y)
    
    draw_left(node.left, x, y, block) if node.left != nil
    draw_right(node.right, x, y, block) if node.right != nil
  end
  
  def draw_right(node, parent_x, parent_y, block)
    if node.left != nil
      count = 1+ children_count(node.left)
    else
      count = 0
    end
    x = parent_x + @x_distance + (count*@x_distance)
    y = parent_y + @y_distance

    block.call(node.value,x,y, parent_x, parent_y)
    
    draw_left(node.left, x, y, block) if node.left != nil
    draw_right(node.right, x, y, block) if node.right != nil
  end
  
  def children_count(node)
    count = 0
    
    if node.left != nil
      count += 1 + children_count(node.left)
    end
    
    if node.right != nil
      count += 1 + children_count(node.right)
    end
    
    return count
  end
  
end