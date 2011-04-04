#!/usr/bin/env ruby

$: << File.expand_path(File.dirname(__FILE__) + "/lib")
require "rubygems"
require "sinatra"
require "web_draw_binary_tree_controller"

TreeDataClass = Struct.new(:centerX, :offsetY, 
  :canvas_width, :canvas_height, 
  :count, :min_value, :max_value, :height, 
  :warning_message, :draw_javascript, :list_nodes, :sort_message)

  
get '/' do
  erb :home
end
 

get '/random/:howMany' do |howMany|
  controller = DrawTreeController.new()
  controller.random_tree(howMany)
  @data = controller_to_data_class(controller)
  erb :draw_binary_tree
end


get '/custom/?' do
  erb :custom_tree_get
end


post '/custom/?' do
  controller = DrawTreeController.new()
  controller.custom_tree(params[:txtValues])
  @data = controller_to_data_class(controller)
  erb :draw_binary_tree
end


get '/hello' do
  erb :hello
end


def controller_to_data_class(controller)
  data = TreeDataClass.new()
  data.warning_message = controller.html_warning_message
  data.centerX = controller.canvas_centerX
  data.offsetY = controller.canvas_offsetY
  data.draw_javascript = controller.javascript_draw
  data.canvas_width = controller.canvas_width
  data.canvas_height = controller.canvas_height
  data.count = controller.tree.count
  data.height = controller.tree.height
  data.min_value = controller.tree.min.value
  data.max_value = controller.tree.max.value
  data.list_nodes = controller.node_list
  data.sort_message = controller.sort_message 
  return data 
end

# http://www.sinatrarb.com/faq.html#escape_html
helpers do
    include Rack::Utils
    alias_method :h, :escape_html
end
