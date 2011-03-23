require "binarytree"

class BinaryTreeDrawer
  
  attr_accessor :x_distance, :y_distance

  def initialize(tree, x_distance=20, y_distance=30)
    @tree = tree
    @x_distance = x_distance
    @y_distance = y_distance
  end  
  
  # Walks the tree from the root and calculates the coordinates
  # where each of its node should be drawn. This method does 
  # not draw the tree per-se but rather calls the specified block
  # with the coordinates where the block should be drawn.
  # 
  # The call to the _block_ passes the value of the node, the x, y 
  # coordinates where the node should be drawn, and the x,y coordinates 
  # where the parent node was drawn. For the root node the x, y coordinates 
  # of the parent node are the same as the x, y coordinates of the node as 
  # there is no parent for the root node. 
  #
  # The x coordiante for each child node will be at least @x_distance from
  # its parent node. The y coordiante for each level of the tree will be 
  # at least y_distance from the previous level.
  def draw(x, y, block)
    draw_node(@tree.root, x, y, block)
  end

  # Same functionality as draw but you can specified the starting
  # node. 
  def draw_node(node, x, y, block)
    return if node == nil
    block.call(node.value, x, y, x, y)
    draw_left(node.left, x, y, block) if node.left != nil
    draw_right(node.right, x, y, block) if node.right != nil
  end
  
  private
  # Calculates the coordinates to draw a node (and all its children)
  # to the left of another node. 
  def draw_left(node, parent_x, parent_y, block)
    if node.right != nil
      count = 1 + children_count(node.right)
    else
      count = 0
    end
    x = parent_x - @x_distance - (count*@x_distance)
    y = parent_y + @y_distance
    block.call(node.value, x, y, parent_x, parent_y)
    
    draw_left(node.left, x, y, block) if node.left != nil
    draw_right(node.right, x, y, block) if node.right != nil
  end
  
  # Calculates the coordinates to draw a node (and all its children)
  # to the right of another node.
  def draw_right(node, parent_x, parent_y, block)
    if node.left != nil
      count = 1 + children_count(node.left)
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
    stack = []
    ignore_left = false

    while(true)

      if ignore_left
        ignore_left = false
      else	      
        if node.left != nil
          count += 1
          stack << node
          node = node.left
          next
        end
      end

      if node.right != nil
        count += 1
        node = node.right
        next
      end

      break if stack.length == 0

      node = stack.pop
      ignore_left = true
    end
    
    return count
  end
  
  # A recursive version of children_count. Code is much simpler than the 
  # non-recursive but I am not sure it's a good idea to recurse so much
  # when the tree is very large (say 1000 nodes or more)
  def children_count_r(node)
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