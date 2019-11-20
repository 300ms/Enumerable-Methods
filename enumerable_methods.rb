Module Enumerable
def my_each(arr)
  x=[]
  i=0
  while i<array.length
    x.push(yield(arr[i]))
    i+=1
  end
  return x
end

def my_each_with_index(arr)
  x=[]
  i=0
  while i<array.length
    x.push(yield(arr[i],i))
    i+=1
  end
  return x
end

def my_select(arr)
  x=[]
  i=0
  while i<array.length
    if yield(arr[i])
      x.push(arr[i])
    end
    i+=1
  end
  return x
end

def my_all?(arr)
  x=true
  i=0
  while i<array.length
    if !yield(arr[i])
      x=false
    end
    i+=1
  end
  return x
end

def my_any?(arr)
  i=0
  while i<array.length
    if yield(arr[i])
      return true
    end
    i+=1
  end
  return false
end

def my_none?(arr)
  x=true
  i=0
  while i<array.length
    if yield(arr[i])
      x=false
    end
    i+=1
  end
  return x
end

def my_count(arr)
  x=0
  i=0
  while i<array.length
    if yield(arr[i])
      x+=1
    end
    i+=1
  end
  return x
end

def my_inject(arr)
  x=arr[0]
  i=0
  while i<array.length
    x=yield(x,arr[i])
    i+=1
  end
  return x
end

def multiply_els(arr)
  return my_inject(arr) do |y,n|
    y*n
  end
end

def my_map(arr,p=nil)
  x=[]
  i=0
  while i<arr.length
    if block_given?
      yield(arr[i])
    else
      x.push(p.call(arr[i]))
    end
    i+=1
  end
  return x
end

p=Proc.new {|a| a**2}