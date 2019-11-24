# frozen_string_literal: true

# rubocop: disable Metrics/ModuleLength

# rubocop: disable Metrics/BlockNesting

# rubocop: disable Style/IfInsideElse

# rubocop: disable Metrics/CyclomaticComplexity

# rubocop: disable Metrics/PerceivedComplexity

# rubocop: disable Layout/SpaceBeforeBlockBraces

# rubocop: disable Layout/SpaceInsideBlockBraces

module Enumerable
  def my_each
    return to_enum unless block_given?

    arr = self
    i = 0
    x = []
    while i < arr.length
      x.push(yield(arr[i]))
      i += 1
    end
    x
  end

  def my_each_with_index
    return to_enum unless block_given?

    arr = self
    x = []
    i = 0
    while i < arr.length
      x.push(yield(arr[i], i))
      i += 1
    end
    x
  end

  def my_select
    return to_enum unless block_given?

    x = []
    i = 0
    arr = self
    while i < arr.length
      x.push(arr[i]) if yield(arr[i])
      i += 1
    end
    x
  end

  def my_all?(cls = nil)
    arr = self
    if block_given?
      arr.my_each do |x|
        return false unless yield(x)
      end
    elsif cls.nil?
      arr.my_each{ |x| return false unless x }
    elsif cls.is_a? Class
      arr.my_each{ |x| return false unless x.is_a?(cls) }
    elsif cls.is_a? Regexp
      arr.my_each{ |x| return false unless cls =~ x }
    else
      arr.my_each{ |x| return false unless cls == x }
    end
    true
  end

  def my_any?(cls = nil)
    arr = self
    if block_given?
      arr.my_each{ |x| return true if yield(x)}
    elsif cls.nil?
      arr.my_each{ |x| return true if x }
    elsif cls.is_a? Class
      arr.my_each{ |x| return true if x.is_a?(cls) }
    elsif cls.is_a? Regexp
      arr.my_each{ |x| return true if cls =~ x }
    else
      arr.my_each{ |x| return true if cls == x }
    end
    true
  end

  def my_none?(cls = nil)
    arr = self
    if block_given?
      arr.my_each{ |x| return false if yield(x)}
    elsif cls.nil?
      arr.my_each{ |x| return false if x }
    elsif cls.is_a? Class
      arr.my_each{ |x| return false if x.is_a?(cls) }
    elsif cls.is_a? Regexp
      arr.my_each{ |x| return false if cls =~ x }
    else
      arr.my_each{ |x| return false if cls == x }
    end
    true
  end

  def my_count(item = nil)
    arr = self
    x = 0
    i = 0
    if item.nil?
      while i < arr.length
        if block_given?
          x += 1 if yield(arr[i])
        else
          x += 1 if arr[i]
        end
        i += 1
      end
    else
      while i < arr.length
        x += 1 if item == arr[i]
        i += 1
      end
    end
    x
  end

  def my_inject(initial = nil, sym = nil)
    arr = self
    arr = arr.to_a unless arr.class == Array
    if initial.class == Symbol
      sym = initial.to_sym
      initial = nil
    end
    initial.nil? ? (x = arr[0]) : (x = initial + arr[0])
    i = 1
    if sym.nil?
      while i < arr.length
        x = if block_given?
              yield(x, arr[i])
            else
              [x, arr[i]]
            end
        i += 1
      end
    else
      while i < arr.length
        x = if block_given?
              yield(x.send(sym, arr[i]))
            else
              x.send(sym, arr[i])
            end
        i += 1
      end
    end
    x
  end

  def multiply_els
    arr = self
    if arr.is_a? Array
      arr.my_inject do |y, n|
        y * n
      end
    else
      puts 'Error: Parameter is not an array!'
    end
  end

  def my_map(prc = nil)
    return to_enum unless block_given?

    arr = self
    arr = arr.to_a if arr.class != Array
    x = []
    i = 0
    while i < arr.length
      if block_given?
        x.push(yield(arr[i]))
      else
        x.push(prc.call(arr[i]))
      end
      i += 1
    end
    x
  end
end

# rubocop: enable Metrics/ModuleLength

# rubocop: enable Metrics/BlockNesting

# rubocop: enable Style/IfInsideElse

# rubocop: enable Metrics/CyclomaticComplexity

# rubocop: enable Metrics/PerceivedComplexity

# rubocop: enable Layout/SpaceBeforeBlockBraces

# rubocop: enable Layout/SpaceInsideBlockBraces


puts '---------------------------------------------'
puts 'my_each'
array = [1, 2, 3, 4, 5].my_each { |i| i * i }
p array
p [1, 2, 3, 4, 5, 6].my_each #=> Enumerator

puts '---------------------------------------------'
puts 'my_each_with_index'
hash = {}
%w[cat dog wombat].my_each_with_index do |item, index|
  hash[item] = index
end
puts hash #=> {"cat"=>0, "dog"=>1, "wombat"=>2}
p [1, 2, 3, 4, 5, 6].my_each_with_index #=> Enumerator

puts '---------------------------------------------'
puts 'my_select'
p [1, 2, 3, 4, 5].my_select { |num| num.even? } #=> [2, 4]
arr = [12.2, 13.4, 15.5, 16.9, 10.2]
new_arr = arr.my_select do |num|
  num.to_f > 13.3
end
p new_arr #=> [13.4, 15.5, 16.9]
p [12.2, 13.4, 15.5, 16.9, 10.2].my_select #=> Enumerator

puts '---------------------------------------------'
puts 'my_all?'
puts %w[ant bear cat].my_all? { |word| word.length >= 3 } #=> true
puts %w[ant bear cat].my_all? { |word| word.length >= 4 } #=> false
puts %w[ant bear cat].my_all?(/t/) #=> false
puts [1, 2i, 3.14].my_all?(Numeric) #=> true
puts [nil, true, 99].my_all? #=> false
puts [].my_all? #=> true

puts '---------------------------------------------'
puts 'my_any?'
puts %w[ant bear cat].my_any? { |word| word.length >= 3 } #=> true
puts %w[ant bear cat].my_any? { |word| word.length >= 4 } #=> true
puts %w[ant bear cat].my_any?(/d/) #=> false
puts [nil, true, 99].my_any?(Integer) #=> true
puts [nil, true, 99].my_any? #=> true
puts [].my_any? #=> false

puts '---------------------------------------------'
puts 'my_none?'
puts %w[ant bear cat].my_none? { |word| word.length == 5 } #=> true
puts %w[ant bear cat].my_none? { |word| word.length >= 4 } #=> false
puts %w[ant bear cat].my_none?(/d/) #=> true
puts [1, 3.14, 42].my_none?(Float) #=> false
puts [].my_none? #=> true
puts [nil].my_none? #=> true
puts [nil, false].my_none? #=> true
puts [nil, false, true].my_none? #=> false

puts '---------------------------------------------'
puts 'my_count'
ary = [1, 2, 4, 2]
puts ary.my_count #=> 4
puts ary.my_count(2) #=> 2
puts ary.my_count { |x| (x % 2).zero? } #=> 3

puts '---------------------------------------------'
puts 'my_map'
p [1, 2, 3, 4].my_map { |i| i * i } #=> [1, 4, 9, 16]
p [1, 2, 3, 4].my_map #=> Enumerator

puts '---------------------------------------------'
puts 'my_inject'
puts (5..10).my_inject { |sum, n| sum + n } #=> 45
puts (5..10).my_inject :+ #=> 45
puts (5..10).inject(1) { |product, n| product * n } #=> 151200
puts (5..10).my_inject(1, :*) #=> 151200
longest = %w[cat sheep bear].inject do |memo, word|
  memo.length > word.length ? memo : word
end
puts longest #=> 'sheep'