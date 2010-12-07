
# TODO: 同じ表層形のエントリが複数登録可能か調べる (value を配列にする必要がある？)
# TODO: '#' を含む単語が正常に動作するか？ (あるいは \0)

module Trie
  class DoubleArray
    attr_reader :base, :check

    def initialize(terminal=nil)
      @terminal = terminal ? terminal[0] : '#'[0]
      @base, @check = [nil, 1], [nil, 0]
    end

    # return array of [value, length]
    def common_prefix_search(word)
      word += @terminal.chr
      res = []
      base, check = @base[1], 1
      word.split('').each_with_index do |char, i|
        i, t = base+char[0], base+@terminal
        res << [-@base[t], i+1] if check == @check[t]
        break if !@base[i] || (@check[i] != check)
      	base, check = @base[i], i
      end
      res
    end
  
    # return value
    def exact_match_search(word)
      word += @terminal.chr
      base, check = @base[1], 1
      word.each_byte do |char|
        i = base+char
      	return false if @check[i] != check
        yield base, check if block_given?
      	base, check = @base[i], i
      end
      base < 0 ? base : false
    end

    def build(words)
      stack, visited, down = [], [], true
      stack << [1, 0, words.length-1]
      until stack.empty?
        # parent, left, right
        p, l, r = stack.last

        # collect chars
        chars = []
        l.upto(r) do |i|
          word = words[i] + @terminal.chr
          char = word[stack.length-1]
          next if !char
          chars << char
        end

        if down
          # set @base of parent
          if chars.empty?
            @base[p] = -l
          else
            base = 1
            loop do
              break if chars.all? {|c| !@check[base+c] }
              base += 1
            end
            @base[p] = base
          end
          # set @check of children
          chars.uniq.each {|c| @check[base+c] = p }
        end

        # get next p, l, r
        np, nl, nr = nil
        flg = false
        chars.each_with_index do |char, i|
          if !visited.include?(@base[p]+char)
            if flg && char != chars[i-1]
              nr = l+i-1
              flg = false
            end
            if !np
              nl, np = l+i, @base[p]+char
              flg = true
            end
          end
        end
        nr = r if !nr

        # push or pop
        if np
          visited << np
          stack << [np, nl, nr]
          down = true
        else
          stack.pop
          down = false
        end
      end
    end
  end
end

