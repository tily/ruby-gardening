$:.unshift(File.dirname(__FILE__) + '/../lib') unless $:.include?(File.dirname(__FILE__) + '/../lib')
require 'trie/double_array'

words = %w|bird bison cat|
da = Trie::DoubleArray.new
da.build(words)

0.upto(da.base.length) do |i|
  next unless da.base[i]
  puts "node[#{i}]\tbase:#{da.base[i]}\tcheck:#{da.check[i]}"
end
