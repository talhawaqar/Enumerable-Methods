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
    self.my_each do |n|
      returned_array << n if yield(n)
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
      returned_value += 1 if yield(n)
    end
    returned_value
  end

  def my_map
    return to_enum unless block_given?

    returned_array = []
    i = 0
    while i < length
      returned_array << yield(self[i])
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

test_array = [2, 5, 7]
# r = test_array.my_select {|n| n.even?}
# print r
# Function tu test my_inject
def multiply_els(my_array)
  my_array.my_inject(1) { |multiply, number| multiply * number }
end
multiply = multiply_els(test_array)
print multiply
