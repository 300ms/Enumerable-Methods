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
    false
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
    if initial.nil?
      (x = arr[0])
      i = 1
    else
      (x = initial)
      i = 0
    end
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
