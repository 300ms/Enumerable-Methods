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
    if arr.is_a? Array
      x = []
      i = 0
      while i < arr.length
        x.push(yield(arr[i]))
        i += 1
      end
      x
    else
      puts 'Error: Parameter is not an array!'
    end
  end

  def my_each_with_index
    return to_enum unless block_given?

    arr = self
    if arr.is_a? Array
      x = []
      i = 0
      while i < arr.length
        x.push(yield(arr[i], i))
        i += 1
      end
      x
    else
      puts 'Error: Parameter is not an array!'
    end
  end

  def my_select
    return to_enum unless block_given?

    x = []
    i = 0
    arr = self
    if arr.is_a? Array
      while i < arr.length
        x.push(arr[i]) if yield(arr[i])
        i += 1
      end
      x
    else
      puts 'Error: Parameter is not an array!'
    end
  end

  def my_all?(cls = nil)
    arr = self
    if cls.nil?
      if arr.is_a? Array
        x = true
        i = 0
        while i < arr.length
          if block_given?
            x = false unless yield(arr[i])
          else
            x = false unless arr[i]
          end
          i += 1
        end
        x
      else
        puts 'Error: Parameter is not an array!'
      end
    else
      x = true
      i = 0
      cls.class == Integer.class ? cls = cls : cls = cls.class
      puts cls
      while i < arr.length
        x = false unless arr[i].class == cls
        i += 1
      end
      x
    end
  end

  def my_any?(cls = nil)
    arr = self
    if cls.nil?
      if arr.is_a? Array
        i = 0
        while i < arr.length
          if block_given?
            return true if yield(arr[i])
          else
            return true if arr[i]
          end
          i += 1
        end
        false
      else
        puts 'Error: Parameter is not an array!'
      end
    else
      i = 0
      cls.class == Integer.class ? cls = cls : cls = cls.class
      while i < arr.length
        return true if arr[i].class == cls

        i += 1
      end
      false
    end
  end

  def my_none?(cls = nil)
    arr = self
    if cls.nil?
      if arr.is_a? Array
        x = true
        i = 0
        while i < arr.length
          if block_given?
            x = false if yield(arr[i])
          else
            x = false if arr[i]
          end
          i += 1
        end
        x
      else
        puts 'Error: Parameter is not an array!'
      end
    else
      x = true
      i = 0
      cls.class == Integer.class ? cls = cls : cls = cls.class
      puts cls
      while i < arr.length
        x = false if arr[i].class == cls
        i += 1
      end
      x
    end
  end

  def my_count(item = nil)
    arr = self
    if item.nil?
      if arr.is_a? Array
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
        puts 'Error: Parameter is not an array!'
      end
    else
      if arr.is_a? Array
        x = 0
        i = 0
        while i < arr.length
          x += 1 if item == arr[i]
          i += 1
        end
        x
      else
        puts 'Error: Parameter is not an array!'
      end
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
