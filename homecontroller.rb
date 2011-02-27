class HomeController
  
  def initialize(request)
  end
  
  def get_html_view()
    html = File.read("homeview.html")
    return html
  end
  
end