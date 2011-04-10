# A class to represent a binary tree
class BinaryTree

	attr_accessor :root, :total_nodes

  # Creates a new tree and optionally initializes it with a node 
  # with the _value_ indicated.
	def initialize(first_value = nil)
		if first_value == nil
			@root = nil
			@total_nodes = 0
		else
			@root = Node.new(first_value)
			@total_nodes = 1
		end
	end
	
	# Adds a new node to the tree with the new_value indicated
  def add(new_value)

    if @root == nil
      @root = Node.new(new_value)
      @total_nodes = 1
      return
    end

    current = @root
    while(true)
      if new_value >= current.value
        if current.right == nil
          current.right = Node.new(new_value)
          break
        else
          current = current.right
        end
      else
        if current.left == nil
          current.left = Node.new(new_value)
          break
        else
          current = current.left
        end
      end
    end

    @total_nodes += 1
  end

	# Deletes the first node on the tree with the specified _value_.
	def delete(value)
		node = search(value)
		return if node == nil
		if is_root?(node)
			delete_root()
		else
			delete_node(node)
		end
	end

  def min
    find_min_from_node(@root)
  end
 
  def max
    find_max_from_node(@root)
  end 
  
  def count
    return @total_nodes
  end
  
  # Processes each node in the tree in order. Yields execution on each
  # node. For example you can use it as follows:
  #
  #     tree.walk { |n| puts "#{n.value}" }
  #
  def walk
    return nil if @root == nil
    node = @root
    stack = []
    ignore_left = false

    while(true)

      #p "processing #{node.value.to_s}"
      if ignore_left
        #p "ignoring left"
        ignore_left = false
      else	      
        if node.left != nil
          #p "moving left"
          stack << node
          node = node.left
          next
        end
      end

      yield node

      if node.right != nil
        #p "moving right"
        node = node.right
        next
      end

      break if stack.length == 0

      #p "popping from stack"
      node = stack.pop
      ignore_left = true
    end

  end
  
  # Performs a binary search on the tree. 
  # Returns the node found or nil if no node was found.
  # If a block is passed, yields execution on each node evaluated during the search.
  def search(value)
    node = @root
    while(true)
      return nil if node == nil
      yield node if block_given?
      return node if value == node.value 
      if value < node.value 
        node = node.left
      else
        node = node.right
      end
    end
  end
    
	# Finds the _node_ with the maximum value from the specified _start_node_.
	def find_max_from_node(start_node)
		current = start_node
		while(current != nil)
			break if current.right == nil
			current = current.right
		end
		return current	
	end
  
  # Finds the _node_ with the minimum value from the specified _start_node_.
	def find_min_from_node(start_node)
		current = start_node 	
		while(current != nil)
			break if current.left == nil
			current = current.left
		end
		return current	
	end
	
	# Returns the height of the tree
	def height()
    height_node(@root, 0)
  end
  
  # Returns the height of a node
  def height_node(node, height)
    heightLeft = 0
    heightRight = 0 

    if node.left != nil
      heightLeft = height_node(node.left, height+1) 
    end

    if node.right != nil
      heightRight = height_node(node.right, height+1) 
    end

    [heightLeft, heightRight, height].max 
  end

  # Returns true if the tree is empty
	def is_empty?
		@total_nodes == 0
	end
	
  # Returns a comma delimited string with the values on the tree in order.
	def to_s
	  return "" if @root == nil
	  a = []
	  walk {|n| a << n.value.to_s }
	  a.join(", ")
  end
		
	# Returns a comma delimited string with the values on the in "pre order"
  def to_s_pre_order
    return "" if @root == nil
    values = walk_pre_order_from_node(@root)
  end

	# Returns a comma delimited string with the values on the in "post order"
  def to_s_post_order
    return "" if @root == nil
    values = walk_post_order_from_node(@root)
  end

	# =====================================================================
	private

	# Deletes the specified _node_ from the tree.
	def delete_node(node)

  	# Algorithm taken from
  	# http://www.algolist.net/Data_structures/Binary_search_tree/Removal
	
		parent = find_parent_node(node)
		is_left_node = node.value < parent.value
				
		# case 1
		if node.is_leaf?
			if is_left_node   
				parent.left = nil
			else
				parent.right = nil
			end
			@total_nodes -= 1
			return
		end		
		
		# case 2
		if node.has_one_child_only?
			if is_left_node
				parent.left = node.left if node.has_left_children?
				parent.left = node.right if node.has_right_children?
			else
				parent.right = node.left if node.has_left_children?
				parent.right = node.right if node.has_right_children?
			end
			@total_nodes -= 1
			return
		end
		 
		# case 3 - node has two children
		# Do not decrease total number of nodes here 
		# as the actual delete happens in the recursive call.
		min_node_to_the_right = find_min_from_node(node.right)
		min_value_to_the_right = min_node_to_the_right.value
		delete_node(min_node_to_the_right)
		node.value = min_value_to_the_right		
	end
	
  # Deletes the root node of the tree.
  def delete_root()
		
		if (@root.is_leaf?)
			@root = nil
			@total_nodes = 0
			return
		end
		
		if @root.has_one_child_only?
			if @root.has_left_children?
				@root = @root.left
			else
				@root = @root.right
			end
			@total_nodes -= 1
			return
		end
		
		# Use the same approach as when deleting a node with two
		# children.
		min_node_to_the_right = find_min_from_node(@root.right)
		min_value_to_the_right = min_node_to_the_right.value
		delete_node(min_node_to_the_right)
		@root.value = min_value_to_the_right	
	end

  # Returns the parent node for the indicated _node_.
  # Returns nil if the indicated _node_ is the root of the tree.
  # Raises ArgumentException if the indicated _node_ does not exist on the tree. 
	def find_parent_node(node)
	
		#no parent for root node
		return nil if is_root?(node) 
		
		current = @root
		parent = nil
		node_found = false
		
		while(current != nil)
		  
		  if current.object_id == node.object_id
		    node_found = true
		    break
      end
		  
			parent = current
			if node.value > current.value
				current = current.right
			else
				current = current.left
			end
		end
		
		raise ArgumentError, "Node indicated could not be found." if node_found == false
		
		return parent			
	end	
	
	# Returns true if the indicated _node_ is the root of the tree.
	def is_root?(node)
		return @root.object_id == node.object_id
	end

	# Post order tree walk:
	#		Print the root
	#		Recursively visit the left subtree
	#		Recursively visit the right subtree
	# Reference: http://staff.unak.is/not/yuan/Algorithms%20and%20Data%20Structures/ALG0183-Fall%202007/Week7/7.1/Week%207%20Binary%20Search%20Trees%20(I).pdf
	def walk_pre_order_from_node(node)	
		value = node.value.to_s
	
		if node.left != nil
			value += ", " + walk_pre_order_from_node(node.left)
		end
				
		if node.right != nil
			value += ", " + walk_pre_order_from_node(node.right) 
		end
		
		value	
	end

	# Post order tree walk:
	#		Recursively visit the left subtree
	#		Recursively visit the right subtree
	#   Print the root
	# Reference: http://staff.unak.is/not/yuan/Algorithms%20and%20Data%20Structures/ALG0183-Fall%202007/Week7/7.1/Week%207%20Binary%20Search%20Trees%20(I).pdf
	def walk_post_order_from_node(node)
	  value = ""
		if node.left != nil
			value = walk_post_order_from_node(node.left) + ", "
		end

		if node.right != nil
			value += walk_post_order_from_node(node.right) + ", "
		end

		value	+= node.value.to_s
  end
  	
	# Internal class to represent nodes in the tree
	class Node
		attr_accessor :value, :left, :right
		def initialize(value)
			@value = value
			@left = nil
			@right = nil
		end
		
		def is_leaf?
			return @left == nil && @right == nil
		end

		def has_one_child_only?
			return false if has_left_children? && has_right_children?
			has_left_children? == true || has_right_children? == true
		end
		
		def has_left_children?
			@left != nil
		end
		
		def has_right_children?
			@right != nil
		end
	
	  def <=>(other)
	    @value <=> other.value
    end
    
	end

end


