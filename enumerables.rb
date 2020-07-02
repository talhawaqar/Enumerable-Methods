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
end

array = [1, 2, 3]  
a = array.my_each_with_index { |value,index| print "#{index}#{value} \n" }
print "\n  #{a}\n"
