module Enumerable
  def my_each
    return to_enum unless block_given?
    returned_array = [] 
    i = 0
    while i < length do
      returned_array << self[i]
      yield(self[i])
      i += 1
    end
    returned_array
  end

  def my_each_with_index 
    return to_enum unless block_given?
    returned_array = [] 
    i = 0
    while i < length do
      returned_array << self[i]
      yield(self[i],i)
      i += 1
    end
    returned_array
  end

  def my_select
    return to_enum unless block_given?
    returned_array = []
    self.my_each do |n|
      if yield(n)
        returned_array << n
      end
    end
    returned_array
  end

  def my_all?
    return to_enum unless block_given?
    returned_value = false
    self.my_each do |n|
      if yield(n)
        returned_value = true
      else
        returned_value = false
        break
      end
    end
    returned_value
  end
  
  def my_any?
    return to_enum unless block_given?
    returned_value = false
    self.my_each do |n|
      if yield(n)
        returned_value = true
        break
      end
    end
    returned_value
  end

  def my_none?
    return to_enum unless block_given?
    returned_value = true
    self.my_each do |n|
      if yield(n)
        returned_value = false
        break
      end
    end
    returned_value
  end 

  def my_count
    return length unless block_given?
    returned_value = 0
    self.my_each do |n|
      if yield(n)
        returned_value += 1
      end
    end
    returned_value
  end

  def my_map
    return to_enum unless block_given?
    returned_array = [] 
    i = 0
    while i < length do
      returned_array << yield(self[i])
      i += 1
    end
    returned_array
  end

end

array = [2, 5, 7]  

a = array.my_map {|n| n*2}
print a
