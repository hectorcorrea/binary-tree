require "binarytree"
require "binarytreedrawer"

#tree = BinaryTree.new
#10.times do |x|
#  tree.add(rand(10000))
#end

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

jsDraw = "function draw_canvas() {\r\n"
drawer = BinaryTreeDrawer.new(tree)
minX, maxX = 0, 0
minY, maxY = 0, 0
drawer.draw(0,0, Proc.new { |value, x, y, px, py| 
  
  jsDraw += "draw_circle(centerX + #{x}, #{y}, 5); // #{value}\r\n" 
  jsDraw += "draw_line(centerX + #{x}, #{y}, centerX + #{px}, #{py});\r\n"
  
  minX = x if x < minX
  maxX = x if x > maxX
  
  minY = y if y < minY
  maxY = y if y > maxY
  
  })
jsDraw += "}\r\n"

width = minX.abs + maxX.abs + 100 
height = minY.abs + maxY.abs + 100
centerX =  (width / 2).to_i


#drawer = BinaryTreeDrawer.new(tree)
#drawer.draw(500,10, Proc.new { |value, x, y, px, py| 
#  jsDraw += "draw_circle(#{x}, #{y}, 5); // #{value}\r\n" 
#  jsDraw += "draw_line(#{x}, #{y}, #{px}, #{py});\r\n"
#  })
#jsDraw += "}\r\n"

htmlList = ""
tree.each do |n| 
  htmlList += "<li> #{n.value} </li>\r\n"
end

theHtmlDoc = %{
<!DOCTYPE html >
<html lang = "en" >
<head >
<meta http-equiv = "Content-Type"content = "text/html; charset=utf-8" />
<title > Tree Sample </title>
  	<script src="modernizr-1.6.js" type="text/javascript "></script>
</head>
<body>
	
	<canvas id="theCanvas" width="#{width} " height="#{height}"></canvas>
	
	<script type="text/javascript ">
	if (Modernizr.canvas) {
	  	var theCanvas = document.getElementById("theCanvas");
		var theContext = theCanvas.getContext("2d");
	} 
	else {
		alert("canvas not supported ")
	}
	
	var centerX = #{centerX}
	[placeholder_js]
	
	function draw_line(x1, y1, x2, y2) {
	  	theContext.beginPath();
		theContext.moveTo(x1, y1);
		theContext.lineTo(x2, y2);
		//theContext.fillStyle="#000000";
		//theContext.fill();	
		theContext.strokeStyle= "#000000"
		theContext.stroke();	
	}
	function draw_circle(x, y, radius) {
		theContext.beginPath();
		theContext.arc(x, y, radius, 0, Math.PI * 2, false);
		theContext.fill();
		//theContext.stroke();	
	}
	
	function draw_border() {
	  draw_line(10,10, 100,100);
	}
	
	draw_canvas();
	draw_lines();
	draw_border();
	
	</script>
	<h1>Hello Canvas</h1>
	<ul>
		[placeholder_li]
	</ul>
</body>
</html>
}

theHtmlDoc = theHtmlDoc.gsub("[placeholder_js]", jsDraw )
theHtmlDoc = theHtmlDoc.gsub("[placeholder_li]", htmlList )

puts theHtmlDoc

