# A sample program to benchmark the speed of the binary tree
# versus the built-in array class in Ruby. The expected result
# is that the array is faster since my binary tree is not 
# optimized for speed. 
require "binarytree.rb"
require "benchmark"
#require "profile"

sample_size = 50000
puts "Running benchmark with #{sample_size} elements"

sample_data = []
tree = BinaryTree.new
array_sorted = ""
tree_sorted = ""

Benchmark.bm(9) do |bm|
  bm.report("add to array:") do 
    sample_size.times do
      sample_data << rand(10000)
    end
  end
  bm.report("add to tree: ") do
    sample_size.times do |i|
      tree.add(sample_data[i])
    end
  end
  bm.report("sort array:  ") do
    array_sorted = sample_data.sort.join(", ")
  end
  bm.report("sort tree:   ") do 
    tree_sorted = tree.to_s 
  end
end

if array_sorted != tree_sorted
  puts "Crap! Something went wrong because the array is different tom the tree!"
end

puts "Done"

