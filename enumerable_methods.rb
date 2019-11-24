# frozen_string_literal: true

# rubocop: disable Metrics/ModuleLength

# rubocop: disable Metrics/BlockNesting

# rubocop: disable Style/IfInsideElse

# rubocop: disable Style/ConditionalAssignment

# rubocop: disable Metrics/CyclomaticComplexity

# rubocop: disable Metrics/PerceivedComplexity

# rubocop: disable Lint/UnusedMethodArgument

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
      arr.my_each{ |x| return false if !yield(x)}
    elsif cls.nil?
      arr.my_each{ |x| return false if !x }
    elsif cls.is_a? Class
      arr.my_each{ |x| return false if !(x.is_a?(cls)) }
    elsif cls.is_a? Regexp
      arr.my_each{ |x| return false if !(cls=~x) }
    else
      arr.my_each{ |x| return false if !(cls==x) }
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
      arr.my_each{ |x| return true if (x.is_a?(cls)) }
    elsif cls.is_a? Regexp
      arr.my_each{ |x| return true if (cls=~x) }
    else
      arr.my_each{ |x| return true if (cls==x) }
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
      arr.my_each{ |x| return false if (x.is_a?(cls)) }
    elsif cls.is_a? Regexp
      arr.my_each{ |x| return false if (cls=~x) }
    else
      arr.my_each{ |x| return false if (cls==x) }
    end
    true
  end

  def my_count(item = nil)
    arr = self
    if item.nil?
      x = 0
      i = 0
      while i < arr.length
        if block_given?
          x += 1 if yield(arr[i])
        else
          x += 1 if arr[i]
        end
        i += 1
      end
      x
    else
      x = 0
      i = 0
      while i < arr.length
        x += 1 if item == arr[i]
        i += 1
      end
      x
    end
  end

  def my_inject(initial = nil, sym = nil)
    arr = self
    arr = arr.to_a unless arr.class == Array
    initial.nil? ? (x = arr[0]) : (x = initial + arr[0])
    i = 1
    while i < arr.length
      x = if block_given?
            yield(x, arr[i])
          else
            [x, arr[i]]
          end
      i += 1
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
#
# rubocop: enable Metrics/BlockNesting
#
# rubocop: enable Style/IfInsideElse

# rubocop: enable Style/ConditionalAssignment

# rubocop: enable Metrics/CyclomaticComplexity

# rubocop: enable Metrics/PerceivedComplexity

# rubocop: enable Lint/UnusedMethodArgument


puts %w[ant bear cat].my_all? { |word| word.length >= 3 } #=> true
puts %w[ant bear cat].my_all? { |word| word.length >= 4 } #=> false
puts %w[ant bear cat].my_all?(/t/)                        #=> false
puts [1, 2i, 3.14].my_all?(Numeric)                       #=> true
puts [nil, true, 99].my_all?                              #=> false
puts [].my_all?                                           #=> true

puts %w[ant bear cat].my_all?(/t/)                        #=> false
puts [1, 2i, 3.14].my_all?(Numeric)                       #=> true
