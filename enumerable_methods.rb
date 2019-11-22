# frozen_string_literal: true

# rubocop: disable Metrics/ModuleLength

# rubocop: disable Metrics/BlockNesting

# rubocop: disable Style/IfInsideElse

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

  def my_all?
    arr = self
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
  end

  def my_any?
    arr = self
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
  end

  def my_none?
    arr = self
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
  end

  def my_count
    arr = self
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
  end

  def my_inject
    arr = self
    if arr.is_a? Array
      x = arr[0]
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
    else
      puts 'Error: Parameter is not an array!'
    end
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

  def my_map(prc)
    arr = self
    if arr.is_a? Array
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
    else
      puts 'Error: Parameter is not an array!'
    end
  end
end

# rubocop: enable Metrics/ModuleLength
#
# rubocop: enable Metrics/ModuleLength
#
# rubocop: enable Metrics/ModuleLength
