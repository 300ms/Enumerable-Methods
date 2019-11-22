# frozen_string_literal: true

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
    return to_enum unless block_given?

    arr = self
    if arr.is_a? Array
      x = true
      i = 0
      while i < arr.length
        x = false unless yield(arr[i])
        i += 1
      end
      x
    else
      puts 'Error: Parameter is not an array!'
    end
  end

  def my_any?
    return to_enum unless block_given?

    arr = self
    if arr.is_a? Array
      i = 0
      while i < arr.length
        return true if yield(arr[i])

        i += 1
      end
      false
    else
      puts 'Error: Parameter is not an array!'
    end
  end

  def my_none?
    return to_enum unless block_given?

    arr = self
    if arr.is_a? Array
      x = true
      i = 0
      while i < arr.length
        x = false if yield(arr[i])
        i += 1
      end
      x
    else
      puts 'Error: Parameter is not an array!'
    end
  end

  def my_count
    return to_enum unless block_given?

    arr = self
    if arr.is_a? Array
      x = 0
      i = 0
      while i < arr.length
        x += 1 if yield(arr[i])
        i += 1
      end
      x
    else
      puts 'Error: Parameter is not an array!'
    end
  end

  def my_inject
    return to_enum unless block_given?

    arr = self
    if arr.is_a? Array
      x = arr[0]
      i = 1
      while i < arr.length
        x = yield(x, arr[i])
        i += 1
      end
      x
    else
      puts 'Error: Parameter is not an array!'
    end
  end

  def multiply_els
    return to_enum unless block_given?

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


=begin
---------------TEST VARIABLES------------


arr=[1, 2, 4, 3, 5]

arr2=%w[ant bear cat]

arr3=(5..10).to_a

prc=Proc.new {|a| a**2}


----------------------TEST BLOCKS----------------

arr.my_each do |x|
  puts x
end

arr.my_each_with_index do |x,i|
  if i>2
    puts x*2
  else
    puts x
  end
end

puts arr.my_select { |num| num.even?  }

puts arr2.my_all? { |word| word.length >= 3 }

puts arr2.my_any? { |word| word.length >= 4 }

puts arr2.my_none? { |word| word.length >= 5 }

puts arr.my_count { |x| x%2==0 }

puts arr3.my_inject { |sum=0, n| sum + n }

puts arr3.multiply_els { |sum=0, n| sum + n }

puts arr3.my_map(nil) { |a| a**2 }

puts arr3.my_map(prc)


=end

