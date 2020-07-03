module Enumerable
  def my_each
    return to_enum unless block_given?

    returned_array = []
    i = 0
    while i < length
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
    while i < length
      returned_array << self[i]
      yield(self[i], i)
      i += 1
    end
    returned_array
  end

  def my_select
    return to_enum unless block_given?

    returned_array = []
    my_each do |n|
      returned_array << n if yield(n)
    end
    returned_array
  end

  def my_all?(*arg)

    if arg.length >2 
      return  "`all?': wrong number of arguments (given #{arg.length}, expected 0..1)"

    elsif block_given?
      my_each { |n| return false unless yield(n) }
  
    elsif arg.empty? 
      returned_value = self.include?(nil)? false : true

    elsif arg[0].is_a? Class
      my_each { |n| return false unless n.class.ancestors.include?(arg[0]) }

    elsif arg[0].is_a? Regexp
      my_each { |n| return false unless arg[0].match(n) }
    else
      my_each { |n| return false unless n === arg[0] }
    end
    
    true
  end

  def my_any?
    return to_enum unless block_given?

    returned_value = false
    my_each do |n|
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
    my_each do |n|
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
    my_each do |n|
      returned_value += 1 if yield(n)
    end
    returned_value
  end

  def my_map(proc = nil)
    return to_enum unless block_given?

    returned_array = []
    i = 0
    while i < length
      if proc.nil?
        returned_array << yield(self[i])
      else
        returned_array << yield.call(self[i]) unless yield.call(self[i]).nil?
      end
      i += 1
    end
    returned_array
  end

  def my_inject(accumulator = nil)
    return to_enum unless block_given?

    accumulator = 0 if accumulator.nil?
    i = 0
    while i < length
      accumulator = yield(accumulator, self[i])
      i += 1
    end
    accumulator
  end
end

# Function tu test my_inject
# def multiply_els(my_array)
#   my_array.my_inject(1) { |multiply, number| multiply * number }
# end
# test_array = [2, 3, 4]
# multiply = multiply_els(test_array)
# print multiply

test_array = [1, 2, 5 ]
print test_array.my_all?(1) 
print test_array.all?(1)
