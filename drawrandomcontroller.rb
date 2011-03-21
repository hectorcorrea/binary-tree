require "binarytree"
require "binarytreedrawer"

class DrawRandomController

  attr_accessor :nodes, :tree, :html_warning_message, :html_node_list, :javascript_draw,
    :canvas_width, :canvas_height, :canvas_centerX, :canvas_offsetY
  
  def initialize(howManyNodes)
    @max_demo_nodes = 250
    @max_nodes_to_list = 250
    @html_node_list = ""
    @nodes = validate_request(howManyNodes.to_i)
    generate_tree()
    generate_html()
  end
  
  private
  def validate_request(howManyNodes)
    nodes = howManyNodes

    @html_warning_message = ""

    if nodes <= 0
      @html_warning_message = "An unexpected number of nodes was requested. Defaulting to 10 nodes."
      nodes = 10
    end
    
    if nodes > @max_demo_nodes 
      @html_warning_message = %{
        <p><b>This demo site limits the number of nodes supported to #{@max_demo_nodes}.</b>
        The program to draw the binary tree does support very large number of 
        nodes (e.g. I have tested it up to 10,000 nodes). Check out the code
        and host it on your own if you need to draw more than #{@max_demo_nodes} nodes.</p>
      }
      nodes = @max_demo_nodes 
    end
     
    return nodes
  end
  
  def generate_tree()
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
      labels << "draw_label(centerX + 7 + #{x}, offsetY+5+#{y}, \"#{value}\");"

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
    @html_node_list = ""
    if @tree.count > @max_nodes_to_list
      @html_node_list += "<li> #{tree.count} nodes omitted</li>\r\n"
    else
      @tree.each do |n| 
        @html_node_list += "<li> #{n.value} </li>\r\n"
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