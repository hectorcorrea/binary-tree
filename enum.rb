require "binarytree.rb"
require "benchmark"
require "profile"

def case2_short
  tree = BinaryTree.new(40)
  tree.add(30)
  tree.add(1)
  #tree.add(20)
  tree.add(35)
  tree.add(34)
  tree.add(33)
  tree.walk2
end

def case1_long
  tree = BinaryTree.new(40)
  tree.add(30)
  tree.add(1)
  tree.add(20)
  tree.add(35)
  tree.add(100)
  tree.add(34)
  #r = rand(99)
  r = 33
  tree.add(r)
  tree.add(36)
  tree.walk2
  puts "r=#{r}"
end


sample_size = 5000
puts "Running benchmark with #{sample_size} elements"

a = []
tree = BinaryTree.new
array_sorted = ""
tree_sorted = ""

Benchmark.bm do |bm|
  bm.report("add array: ") do 
    sample_size.times do
      a << rand(10000)
    end
  end
  bm.report("add tree:  ") do
    sample_size.times do |i|
      tree.add(a[i])
    end
  end
  bm.report("sort array:") do
    a = a.sort
    sample_size.times { |i| array_sorted += a[i].to_s + "," }
    array_sorted = array_sorted.chop
  end
  bm.report("sort tree: ") do 
    tree_sorted = tree.walk2 
  end
end

puts "woo-hoo, they are equal" if array_sorted == tree_sorted
puts "oops! something went wrong" if array_sorted != tree_sorted

