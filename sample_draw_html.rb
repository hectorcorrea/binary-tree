#!/usr/bin/env ruby

# Creates a binary tree with the number of nodes indicated
# in the command line and generates and HTML file that can
# draw the binary tree when rendered on a browser that 
# supports HTML 5's canvas element.

require "binarytree"
require "binarytreedrawer"

totalNodes = 10
totalNodes = ARGV[0].to_i if ARGV.count > 0


# Generate the binary tree
puts "Adding #{totalNodes} nodes..."
tree = BinaryTree.new
totalNodes.times do |x|
  tree.add(rand(10_000))
end

puts "Calculating..."
puts "Min = #{tree.min.value}"
puts "Max = #{tree.max.value}"
puts "Height = #{tree.height}"
puts "Count = #{tree.count}"

# Calculate the coordiantes where the nodes should be drawn
# and store in 3 arrays the corresponding calls to draw lines,
# circles, and labels for each of the nodes.
puts "Calculating coordinates for nodes..."
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
puts "Generating HTML..."
htmlList = ""
if totalNodes > 200
  htmlList += "<li> #{totalNodes} nodes omitted</li>\r\n"
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
htmlTemplate = File.read("template.html")
theHtmlDoc = eval "%{" + htmlTemplate + "}"
theHtmlDoc = theHtmlDoc.gsub("[placeholder_js]", jsDraw )
theHtmlDoc = theHtmlDoc.gsub("[placeholder_li]", htmlList )

puts "Open test.html to view the generated HTML"
File.new("test.html", "w").puts(theHtmlDoc)

