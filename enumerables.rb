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
  end
  array = [1, 2, 3]
  
d = array.my_each {|x| puts x}
print d