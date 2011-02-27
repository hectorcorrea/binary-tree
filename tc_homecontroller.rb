require "test/unit"  
require "homecontroller"

class TestHomeController < Test::Unit::TestCase
  def test_return_html
    controller = HomeController.new(nil)
    html = controller.get_html_view()
    assert_not_nil(html)
  end
end
