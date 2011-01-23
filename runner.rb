require "binarytree.rb"

def sample_with_integers
  tree = BinaryTree.new(40)
  tree.add(30)
  tree.add(100)
  tree.add(20)
  tree.add(35)
  tree.add(25)
  tree.add(34)
  return tree
end

def sample_with_strings
  tree = BinaryTree.new("HELLO")
  tree.add("GOODBYE")
  tree.add("HOLA")
  tree.add("ADIOS")
  return tree
end

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

def sample_with_people
  john = Person.new("john", 40)
  jane = Person.new("jane", 39)
  mac = Person.new("mac", 7)
  summer = Person.new("summer", 8)
  tree = BinaryTree.new
  tree.add(john)
  tree.add(jane)
  tree.add(mac)
  tree.add(summer)
  return tree
end

#tree = sample_with_integers
#tree = sample_with_strings
tree = sample_with_people

puts "Tree nodes: #{tree.to_s}"
puts "Tree height: #{tree.height}"
puts "Done"
