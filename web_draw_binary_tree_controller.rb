require "binarytree"
require "binarytreedrawer"

class DrawTreeController

  attr_accessor :nodes, :tree, :html_warning_message, :node_list, :javascript_draw,
    :canvas_width, :canvas_height, :canvas_centerX, :canvas_offsetY, :sort_message
  
  def initialize()
    @max_demo_nodes = 250
    @max_nodes_to_list = 250
    @sort_message = ""
    @html_warning_message = ""
  end
  
  def random_tree(how_many_nodes)
    @all_numbers = true
    @nodes = validate_how_many(how_many_nodes.to_i)
    tree_random(@nodes)
    generate_html()
  end

  def custom_tree(values_string)
    values_array = to_array(values_string)
    @all_numbers = all_values_numeric?(values_array)
    if @all_numbers == false
      @sort_message = "<li>Non-numeric values were found on the tree. Nodes are sorted <b><i>alphabetically</i></b> (i.e. not numerically)</li>"      
    end
    @nodes = values_array.count
    tree_from_array(values_array)
    generate_html()
  end
  
  private
  
  def validate_how_many(how_many_nodes)
    nodes = how_many_nodes

    @html_warning_message = ""

    if nodes <= 0
      @html_warning_message = "<p>An unexpected number of nodes was requested. Defaulting to 10 nodes.</p"
      nodes = 10
    end
    
    if nodes > @max_demo_nodes 
      set_warning_message
      nodes = @max_demo_nodes 
    end
     
    return nodes
  end
  
  def set_warning_message
    @html_warning_message = %{
      <p><b>This demo site limits the number of nodes supported to #{@max_demo_nodes}.</b>
      The program to draw the binary tree does support very large number of 
      nodes (e.g. I have tested it up to 10,000 nodes). Check out the code
      and host it on your own if you need to draw more than #{@max_demo_nodes} nodes.</p>
    }
  end
  
  def to_array(values_string)
      values_array = []
      values_string.each_line do |line|
        
        if values_array.count >= @max_demo_nodes
          set_warning_message()
          break
        end
        
        value = line.chomp()
        next if value == ""
        
        values_array << value

      end
      return values_array
  end
  
  def all_values_numeric?(values_array)
    all_numbers = true
    values_array.each do |value|
      begin
        Integer(value)
      rescue
        all_numbers = false
        break
      end
    end
    return all_numbers
  end
  
  def tree_from_array(values_array)
    @tree = BinaryTree.new
    values_array.each {|value| tree.add( @all_numbers ? value.to_i : value)} 
  end
  
  def tree_random(howMany)
    @tree = BinaryTree.new
    @nodes.times do |x|
      @tree.add(rand(10000))
    end
  end
  
  def generate_html()

    # Calculate the coordiantes where the nodes should be drawn
    # and store in 3 arrays the corresponding calls to draw lines,
    # circles, and labels for each of the nodes.
    minX, maxX = 0, 0
    minY, maxY = 0, 0
    circles = []
    lines = []
    labels = []
    first_node = true
    drawer = BinaryTreeDrawer.new(@tree)
    drawer.draw(0,0, Proc.new { |value, x, y, px, py| 

      if first_node
        circles << "draw_blue_circle(centerX + #{x}, offsetY + #{y}, 5);" 
        first_node = false
      else
        circles << "draw_circle(centerX + #{x}, offsetY + #{y}, 5);" 
      end

      lines << "draw_line(centerX + #{x}, offsetY + #{y}, centerX + #{px}, offsetY + #{py});"
      if @all_numbers
        labels << "draw_label(centerX + 7 + #{x}, offsetY+5+#{y}, \"#{value}\");"
      else      
        labels << "draw_label(centerX + 7 + #{x}, offsetY+5+#{y}, \"#{value[0..9]}\");"
      end
      minX = x if x < minX
      maxX = x if x > maxX

      minY = y if y < minY
      maxY = y if y > maxY

      })

    @canvas_width = minX.abs + maxX.abs + 80 
    @canvas_height = minY.abs + maxY.abs + 40
    @canvas_centerX =  minX.abs + 20
    @canvas_offsetY = 20

    # Generate the HTML code to list the values in the tree
    # (only trees with 200 or less nodes) 
    @node_list = []
    if @tree.count > @max_nodes_to_list
      @node_list << "#{tree.count} nodes omitted"
    else
      @tree.walk do |n| 
        @node_list << "#{n.value}"
      end
    end

    # Dump the individual calls to draw circles, lines, and labels
    # into a single JavaScript function.
    @javascript_draw = %{
    function draw_canvas() {
      #{circles.join("\r\n\t")}
      #{lines.join("\r\n\t")}
      #{labels.join("\r\n\t")}
      }
    }    
    
  end
   
end