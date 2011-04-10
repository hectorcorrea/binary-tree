puts "file:" + __FILE__ 
puts "full:" + File.expand_path(File.dirname(__FILE__) + "/../lib")

$: << File.expand_path(File.dirname(__FILE__) + "/../lib")
$: << File.expand_path(File.dirname(__FILE__) + "/../test")
require "test/unit"
require "tc_binarytree"
require "tc_binarytree_delete"
require "tc_height"
require "tc_drawer"
require "tc_draw_controller"