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
    my_each { |n| returned_array << n if yield(n) }
    returned_array
  end

  def my_all?(*arg)
    return "`all?': wrong number of arguments (given #{arg.length}, expected 0..1)" if arg.length > 1

    if block_given?
      my_each { |n| return false unless yield(n) }

    elsif arg.empty?
      return include?(nil) ? false : true

    elsif arg[0].is_a? Class
      my_each { |n| return false unless n.class.ancestors.include?(arg[0]) }

    elsif arg[0].is_a? Regexp
      my_each { |n| return false unless arg[0].match(n) }
    else
      my_each { |n| return false unless n == arg[0] }
    end

    true
  end

  def my_any?(*arg)
    return "`my_any?': wrong number of arguments (given #{arg.length}, expected 0..1)" if arg.length > 1

    if block_given?
      my_each { |n| return true if yield(n) }

    elsif arg.empty?
      return true

    elsif arg[0].is_a? Class
      my_each { |n| return true if n.class.ancestors.include?(arg[0]) }

    elsif arg[0].is_a? Regexp
      my_each { |n| return true if arg[0].match(n) }

    else
      my_each { |n| return true if n == arg[0] }
    end

    false
  end

  def my_none?(*arg)
    return "`my_none?': wrong number of arguments (given #{arg.length}, expected 0..1)" if arg.length > 1

    if block_given?
      my_each { |n| return false if yield(n) }

    elsif arg.empty?
      my_each { |n| return false unless n.nil? || n == false }

    elsif arg[0].is_a? Class
      my_each { |n| return false if n.class.ancestors.include?(arg[0]) }

    elsif arg[0].is_a? Regexp
      my_each { |n| return false if arg[0].match(n) }
    else
      my_each { |n| return false if n == arg[0] }
    end

    true
  end

  def my_count(*arg)
    returned_value = 0

    return "`my_none?': wrong number of arguments (given #{arg.length}, expected 0..1)" if arg.length > 1

    if block_given?
      my_each { |n| returned_value += 1 if yield(n) }
    elsif arg.empty?
      returned_value = length
    else
      my_each { |n| returned_value += 1 if n == arg[0] }
    end

    returned_value
  end

  def my_map(proc = nil)
    returned_array = []
    my_each do |n|
      returned_array << if proc.nil?
                          yield(n)
                        else
                          proc.call(n)
                        end
    end
    returned_array
  end

  def my_inject(*arg)
    accumulator = 0

    calculations = {
      :+ => proc { |x, y| x + y },
      :- => proc { |x, y| x - y },
      :/ => proc { |x, y| x / y },
      :* => proc { |x, y| x * y }
    }

    if arg.empty? && block_given?
      my_each { |n| accumulator = yield(accumulator, n) }

    elsif arg.length == 1 && block_given?
      accumulator = arg[0]
      my_each { |n| accumulator = yield(accumulator, n) }

    elsif arg.length == 1 && !block_given?
      accumulator = arg[0] == :+ || arg[0] == :- ? 0 : 1
      my_each { |n| accumulator = calculations[arg[0]].call(accumulator, n) }

    elsif arg.length == 2
      accumulator = arg[0]
      my_each { |n| accumulator = calculations[arg[1]].call(accumulator, n) }
    end

    accumulator
  end
end

# Function to test my_inject
def multiply_els(my_array)
  my_array.my_inject(:*)
end

test_array = [2, 3, 4]
multiply = multiply_els(test_array)
print multiply
