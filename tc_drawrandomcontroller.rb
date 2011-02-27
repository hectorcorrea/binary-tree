require "test/unit"  
require "drawrandomcontroller"

class TestDrawRandomController < Test::Unit::TestCase
  
  Request = Struct.new(:path_info)
  
  def test_return_html
    request = Request.new("/5")
    controller = DrawRandomController.new(request)
    html = controller.get_html_view()
    assert_not_nil(html)
    #puts html
  end
  
  def test_default_number_of_nodes   
    request = Request.new("")
    controller = DrawRandomController.new(request)
    nodes = controller.nodes
    assert_equal(10, nodes)
  end
  
  def test_too_many_nodes   
    request = Request.new("/5000")
    controller = DrawRandomController.new(request)
    nodes = controller.nodes
    assert_equal(100, nodes)
  end
  
  def test_negative_nodes   
    request = Request.new("/-9")
    controller = DrawRandomController.new(request)
    nodes = controller.nodes
    assert_equal(10, nodes)
  end
  
end
