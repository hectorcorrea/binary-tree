require "binarytree"
require "binarytreedrawer"

class DrawRandomController

  attr_accessor :nodes, :tree
  
  def initialize(request)
    @max_demo_nodes = 100
    @warning = ""
    @nodes = validate_request(request)
    @tree = generate_tree(@nodes)
  end
  
  def get_html_view()
    html = generate_html(@tree)
    return html
  end
  
  private
  def validate_request(request)
    nodes = 10
    return nodes if request.path_info == ""
    
    parts = request.path_info.split("/")
    if parts.length == 2
      
      nodes = parts[1].to_i 
      
      if nodes <= 0
        @warning = "An unexpected number of nodes was requested. Defaulting to 10 nodes."
        nodes = 10
      end
      
      if nodes > @max_demo_nodes 
        @warning = %{
          <p><b>This demo site limits the number of nodes supported to #{@max_demo_nodes}.</b>
          The program to draw the binary tree does support very large number of 
          nodes (e.g. I have tested it up to 10,000 nodes). Check out the code
          and host it on your own if you need to draw more than #{@max_demo_nodes} nodes.</p>
        }
        nodes = @max_demo_nodes 
      end
    
    end
    
    return nodes
  end
  
  def generate_tree(nodes)
    tree = BinaryTree.new
    nodes.times do |x|
      tree.add(rand(1000))
    end
    return tree
  end
  
  def generate_html(tree)

    # Calculate the coordiantes where the nodes should be drawn
    # and store in 3 arrays the corresponding calls to draw lines,
    # circles, and labels for each of the nodes.
    minX, maxX = 0, 0
    minY, maxY = 0, 0
    circles = []
    lines = []
    labels = []
    first_node = true
    drawer = BinaryTreeDrawer.new(tree)
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

    width = minX.abs + maxX.abs + 80 
    height = minY.abs + maxY.abs + 40
    centerX =  minX.abs + 20
    offsetY = 20

    # Generate the HTML code to list the values in the tree
    # (only trees with 200 or less nodes) 
    htmlList = ""
    if tree.count > 200
      htmlList += "<li> #{tree.count} nodes omitted</li>\r\n"
    else
      tree.each do |n| 
        htmlList += "<li> #{n.value} </li>\r\n"
      end
    end

    # Dump the individual calls to draw circles, lines, and labels
    # into a single JavaScript function.
    jsDraw = %{
    function draw_canvas() {
      #{circles.join("\r\n\t")}
      #{lines.join("\r\n\t")}
      #{labels.join("\r\n\t")}
      }
    }

    # Generate the final HTML to draw the binary tree.
    htmlTemplate = File.read("drawrandomview.html")
    htmlDoc = eval "%{" + htmlTemplate + "}"
    htmlDoc = htmlDoc.gsub("[placeholder_warning]", @warning )
    htmlDoc = htmlDoc.gsub("[placeholder_li]", htmlList )
    htmlDoc = htmlDoc.gsub("[placeholder_js]", jsDraw )
    
    return htmlDoc
  end
   
end