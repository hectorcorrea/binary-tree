#!/usr/bin/env ruby

require "binarytree"
require "binarytreedrawer"

totalNodes = 10
totalNodes = ARGV[0].to_i if ARGV.count > 0

puts "Adding #{totalNodes} nodes..."
tree = BinaryTree.new
totalNodes.times do |x|
  tree.add(rand(10000))
end

puts "Calculating coordinates..."
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

#puts "minX=#{minX}, maxX=#{maxX}"
#puts "width=#{width}, height=#{height}"
#puts "centerX=#{centerX}"

puts "Generating HTML..."
htmlList = ""
if totalNodes > 200
  htmlList += "<li> #{totalNodes} nodes omited</li>\r\n"
else
  tree.each do |n| 
    htmlList += "<li> #{n.value} </li>\r\n"
  end
end

jsDraw = "function draw_canvas() {\r\n" + circles.join("\r\n") + lines.join("\r\n") + labels.join("\r\n") + "}\r\n"

theHtmlDoc = %{
<!DOCTYPE html>
<html lang = "en">
<head>
<meta http-equiv = "Content-Type"content = "text/html; charset=utf-8" />
<title>Binary Tree</title>
  	<script src="modernizr-1.6.js" type="text/javascript "></script>
</head>
<body>
	
	<h1>Binary Tree</h1>
	
	<canvas id="theCanvas" width="#{width} " height="#{height}"></canvas>
	
  <script type="text/javascript">
  if (Modernizr.canvas) {
    var theCanvas = document.getElementById("theCanvas");
    var theContext = theCanvas.getContext("2d");
  } 
  else {
    alert("canvas not supported ")
  }

  var centerX = #{centerX};
  var offsetY = #{offsetY}
  [placeholder_js]

  function draw_line(x1, y1, x2, y2) {
    theContext.beginPath();
    theContext.moveTo(x1, y1);
    theContext.lineTo(x2, y2);
    theContext.fillStyle="#000000";
    //theContext.fill();	
    theContext.strokeStyle= "#000000"
    theContext.stroke();	
  }
  function draw_circle(x, y, radius) {
    theContext.beginPath();
    theContext.arc(x, y, radius, 0, Math.PI * 2, false);
    theContext.fillStyle="#000000";
    theContext.fill();
    //theContext.stroke();	
  }

  function draw_blue_circle(x, y, radius) {
    theContext.beginPath();
    theContext.arc(x, y, radius, 0, Math.PI * 2, false);
    theContext.fillStyle="#0000FF";
    theContext.fill();
    //theContext.stroke();	
  }

  function draw_label(x, y, text) {
    theContext.font = "10px sans-serif";
    theContext.fillText(text, x, y);
  }

  function draw_border() {
    draw_line(0, 0, #{width}, 0);
    draw_line(#{width}, 0, #{width}, #{height});
    draw_line(#{width}, #{height}, 0, #{height} );
    draw_line(0,#{height}, 0, 0);
  }

  draw_canvas();
  draw_border();
  </script>
  
  <p>Tree Properties</p>
  <ul>
  <li>Min value = #{tree.min.value}
  <li>Max value = #{tree.max.value}
  <li>Tree Height = #{tree.height}
  </ul>
  
  <p>Values (in order)</p>
	<ul>
		[placeholder_li]
	</ul>
</body>
</html>
}

theHtmlDoc = theHtmlDoc.gsub("[placeholder_js]", jsDraw )
theHtmlDoc = theHtmlDoc.gsub("[placeholder_li]", htmlList )

puts "Open test.html to view the generated HTML"
File.new("test.html", "w").puts(theHtmlDoc)

