#!/usr/bin/env ruby
  
require "rubygems"
require "sinatra"
require "homecontroller"
require "drawrandomcontroller"

DataClass = Struct.new(:centerX, :offsetY, 
  :canvas_width, :canvas_height, 
  :count, :min_value, :max_value, :height, 
  :warning_message, :draw_javascript, :list_nodes)


get '/' do
  erb :home
end
 
get '/random/:howMany' do |n|
  
  controller = DrawRandomController.new(n)
  
  @data = DataClass.new()
  @data.warning_message = controller.html_warning_message
  @data.centerX = controller.canvas_centerX
  @data.offsetY = controller.canvas_offsetY
  @data.draw_javascript = controller.javascript_draw
  @data.canvas_width = controller.canvas_width
  @data.canvas_height = controller.canvas_height
  @data.count = controller.tree.count
  @data.height = controller.tree.height
  @data.min_value = controller.tree.min.value
  @data.max_value = controller.tree.max.value
  @data.list_nodes = controller.html_node_list
  
  erb :randomtree
  
end

get '/hello' do
  erb :hello
end