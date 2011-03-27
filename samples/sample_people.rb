#!/usr/bin/env ruby

# Sample of using the binary tree class with a custom class that 
# implements Comparable operations

$: << File.expand_path(File.dirname(__FILE__) + "/../lib")
require "binarytree"

class Person 
  include Comparable
  
  attr_accessor :name, :age
  
  def initialize(name, age)
    @name = name
    @age = age
  end
  
  def <=>(other)
    @name <=> other.name
  end
  
  def to_s
    return name
  end
    
end

john = Person.new("john", 30)
jane = Person.new("jane", 29)
mac = Person.new("mac", 7)
summer = Person.new("summer", 8)
tree = BinaryTree.new
tree.add(john)
tree.add(jane)
tree.add(mac)
tree.add(summer)

puts "Tree nodes: #{tree.to_s}"
puts "Tree height: #{tree.height}"
puts

# Perform a binary search. The comparison will be performed as defined in 
# the <=> operator in the Person class.
found = tree.search( Person.new("summer", 8) )
puts "Node found = #{found.value}"
puts

# Walk the entire tree in ascending order (the order is defined by 
# the <=> operator in the Person class.
puts "Who can drive?"
tree.walk do |n|
  puts "#{n.value.name} (#{n.value.age})" if n.value.age >= 18
end

