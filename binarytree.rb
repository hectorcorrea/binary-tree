class BinaryTree

	attr_accessor :root, :total_nodes

	def initialize(first_value = nil)
		if first_value == nil
			@root = nil
			@total_nodes = 0
		else
			@root = Node.new(first_value)
			@total_nodes = 1
		end
	end
	
	#
	# Adds a new value to the tree
	#
	def add(new_value)
	
	  if @root == nil
			@root = Node.new(first_value)
			@total_nodes = 1
		else
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
		end
		
		@total_nodes += 1
		
	end
	
	def is_empty?
		@total_nodes == 0
	end
	
	def height()
    height_node(@root, 0)
  end
  
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
  
	# 
	# Looks for a value in the tree and returns the node that was found
	# 
	def find(value)
	
		current = @root
		while(current != nil)
			break if current.value == value
			
			if value > current.value 
				current = current.right
			else
				current = current.left
			end
			
			break if current == nil
		end
		
		return current	
	end
	
	def find_min(start_node = nil)
		current = start_node != nil ? start_node : @root
				
		while(current != nil)
			break if current.left == nil
			current = current.left
		end

		return current	
	end
	
	def find_max(start_node = nil)

		current = start_node != nil ? start_node : @root 

		while(current != nil)
			break if current.right == nil
			current = current.right
		end

		return current	
	end
	
	# Algorithm taken from
	# http://www.algolist.net/Data_structures/Binary_search_tree/Removal
	def delete_node(node)
	
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
		min_node_to_the_right = find_min(node.right)
		min_value_to_the_right = min_node_to_the_right.value
		delete_node(min_node_to_the_right)
		node.value = min_value_to_the_right		
	end
	
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
		min_node_to_the_right = find_min(@root.right)
		min_value_to_the_right = min_node_to_the_right.value
		delete_node(min_node_to_the_right)
		@root.value = min_value_to_the_right	
	end
	
	def delete(value)
		node = find(value)
		return if node == nil
		if is_root(node)
			delete_root()
		else
			delete_node(node)
		end
	end
	
	def is_root(node)
		return @root == node 
	end
	
	def find_parent_node(node)
	
		#no parent for root node
		return nil if @root.object_id == node.object_id 
		
		current = @root
		parent = nil
		
		while(current != nil)
		
			break if current.object_id == node.object_id
			parent = current
			if node.value > current.value
				current = current.right
			else
				current = current.left
			end
		end
		
		return parent			
	end	
	
	#
	# Walks the tree in order and returns a comma delimited string with the values
	#
	def walk
		walk_in_order
	end
	
	def walk_in_order
	  return "" if @root == nil
		values = walk_in_order_from_node(@root)
	end
	
	def walk_pre_order
	  return "" if @root == nil
		values = walk_pre_order_from_node(@root)
	end
	
	def walk_post_order
		return "" if @root == nil
		values = walk_post_order_from_node(@root)
	end
	
	private
	
	# Walk In-Order: Left child, root, right child.
	def walk_in_order_from_node(node)	
		value = ""
		if node.left != nil
			value = walk_in_order_from_node(node.left) + ", "
		end
		
		value += node.value.to_s
		
		if node.right != nil
			value += ", " + walk_in_order_from_node(node.right) 
		end
		
		value	
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
	
	end

end


