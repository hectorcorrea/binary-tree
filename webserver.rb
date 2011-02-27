require "webrick"
require "homecontroller"
require "drawrandomcontroller"

class HomeServlet < WEBrick::HTTPServlet::AbstractServlet
  def do_GET(request, response)
    
    if request.path == "/favicon.ico"
      response.body = "Not found"
      response.status = 404
      response.content_type = "text/html"
      return
    end
        
    if request.path == "/binarytree.png"
      response.body = File.read("binarytree.png")
      response.status = 200
      response.content_type = "image/png"
      return
    end
    
    if request.path == "/"
      controller = HomeController.new(request)
      response.body = controller.get_html_view()
      response.status = 200
      response.content_type = "text/html"
      return
    end

    homeUrl = "http://#{request.host}:#{request.port}/"
    response.status = 302
    response["location"] = homeUrl
    response.content_type = "text/html"
    
  end
end

class DrawRandomServlet < WEBrick::HTTPServlet::AbstractServlet
  def do_GET(request, response)
    controller = DrawRandomController.new(request)
    response.body = controller.get_html_view()
    response.status = 200
    response.content_type = "text/html"
  end
end

puts "Listening for requests at http://localhost:1234"
puts

server = WEBrick::HTTPServer.new( :Port => 1234 )
server.mount "/", HomeServlet
server.mount "/random", DrawRandomServlet
trap("INT") { server.shutdown }
server.start 
