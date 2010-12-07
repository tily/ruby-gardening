$:.unshift(File.dirname(__FILE__) + '/../lib') unless $:.include?(File.dirname(__FILE__) + '/../lib')
require 'trie/double_array'

# 適当に作った CSV の辞書 (「表層,意味」の形式)
dic = <<EOD
あめ,雨(名詞)
あめりか,アメリカ(名詞)
か,か(助詞、疑問)
か,蚊(名詞)
かに,蟹(名詞)
さ,差(名詞)
じ,じ(助詞、意志打ち消し)
じ,字(名詞)
そで,袖(名詞)
で,で(接続詞)
でも,デモ(名詞)
に,二(数詞)
に,に(接続詞)
ぬらさ,濡らさ(動詞、未然形)
ふ,麩(名詞)
ふる,降る(動詞、終止形)
ふる,降る(動詞、連体形)
め,目(名詞)
め,芽(名詞)
も,も(接続詞)
り,利(名詞)
りか,理科(名詞)
EOD

# 単語の表層がユニークなものを配列としてまとめる
words, features = [], []
prev, tmp = '', []
dic.each_with_index do |line, i|
  word, feature = line.chomp.split(',')
  if i == 0 || word == prev
    tmp << feature
  else
    words << prev
    features << tmp
    tmp = [feature]
  end
  prev = word
end
words << prev
features << tmp

# Double-Array の構築
da = Trie::DoubleArray.new
da.build(words)

# Common-Prefix Search
key = 'ふるあめりかにそでもぬらさじ'
while key != ''
  res = da.common_prefix_search(key)
  puts "- #{key}"
  if res && res.size > 0
    res.each do |i, len|
      w, f = words[i][0,len], features[i]
      puts "  - #{w} [#{f.join('/')}]"
    end
  else
    puts "  - [no match]"
  end
  key = key.split(//u)[1..-1].join
end

