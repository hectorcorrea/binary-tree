$: << File.expand_path(File.dirname(__FILE__) + "/../lib")
$: << File.expand_path(File.dirname(__FILE__) + "/../")
require "test/unit"  
require "web_drawrandomcontroller"

class TestDrawRandomController < Test::Unit::TestCase
  
  Request = Struct.new(:path_info)
  
  def test_return_javascript
    controller = DrawRandomController.new(5)
    assert(controller.html_warning_message == "")
    assert(controller.javascript_draw != "")
    assert_equal(5, controller.nodes)
  end
  
  def test_default_number_of_nodes   
    controller = DrawRandomController.new(5)
    assert(controller.html_warning_message == "")
    assert_equal(5, controller.nodes)
  end
  
  def test_too_many_nodes   
    controller = DrawRandomController.new(5000)
    assert(controller.html_warning_message != "")
    assert(controller.nodes < 5000)
 end
  
  def test_negative_nodes   
    controller = DrawRandomController.new(-9)
    assert(controller.html_warning_message != "")
    assert(controller.nodes > 0)
  end
  
end
