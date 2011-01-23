require "binarytree.rb"

class Person 
  include Comparable
  
  attr_accessor :name, :age
  
  def initialize(name, age)
    @name = name
    @age = age
  end
  
  def <=>(other)
    @age <=> other.age
  end
  
  def to_s
    return name + "(#{age})"
  end
    
end

john = Person.new("hector", 38)
jane = Person.new("karla", 36)
mac = Person.new("mac", 7)
summer = Person.new("summer", 8)
tree = BinaryTree.new
tree.add(john)
tree.add(jane)
tree.add(mac)
tree.add(summer)

puts "Tree nodes: #{tree.to_s}"
puts "Tree height: #{tree.height}"
puts "Done"
