require_relative '../enumerables.rb'

describe Enumerable do
  let(:my_array) { [1, 2, 3, 4, 5] }
  let(:my_hash) { { a: 1, b: 2 } }
  let(:my_proc) { proc { |x| x < 3 } }

  describe '#my_each' do
    it 'iterates to entire array of numbers and return array' do
      expect(my_array.my_each { |x| x }).to eq([1, 2, 3, 4, 5])
    end

    it 'iterates to range of numbers and return range' do
      expect((1..5).my_each { |x| x }).to eq(1..5)
    end

    it 'it returns enumerable when no block is passed' do
      expect((1..5).my_each).to be_a Enumerable
    end

    it 'it iterates through hash and it returns hash' do
      expect(my_hash.my_each { |x| x }).to eq({ a: 1, b: 2 })
    end

    it 'calculate sum for each element of an array' do
      sum = 0
      my_array.my_each { |x| sum = x + sum }
      expect(sum).to eq(15)
    end
  end

  describe '#my_each_with_index' do
    it 'iterates to entire array of numbers and return array' do
      expect(my_array.my_each_with_index { |x, _y| x }).to eq([1, 2, 3, 4, 5])
    end

    it 'iterates to range of numbers and return range' do
      expect((1..5).my_each_with_index { |x, _y| x }).to eq(1..5)
    end

    it 'it returns enumerable when no block is passed' do
      expect((1..5).my_each_with_index).to be_a Enumerable
    end

    it 'it iterates through hash and it returns hash' do
      expect(my_hash.my_each_with_index { |x, _y| x }).to eq({ a: 1, b: 2 })
    end

    it 'calculate sum for each element of an array' do
      sum = 0
      my_array.my_each_with_index { |_x, y| sum = y + sum }
      expect(sum).to eq(10)
    end
  end

  describe '#my_select' do
    it 'selects an item in the array and returns true' do
      expect(my_array.my_select { |x| x > 3 }).to eq([4, 5])
    end

    it 'returns enumerable when no block is given' do
      expect(my_array.my_select).to be_a Enumerable
    end
  end

  describe '#my_all?' do
    it 'returns true if all elements of my_array is equal to 3' do
      expect(my_array.my_all? { |x| x == 3 }).to eq(false)
    end

    it 'returns true for truth array' do
      expect([true, 1, true].my_all?).to eq(true)
    end

    it 'returns false for false array' do
      expect([true, 1, true, false].my_all?).to eq(false)
    end

    it 'returns true if all element of my_array has a datatype of Integer' do
      expect(my_array.my_all?(Integer)).to eq(true)
    end

    it 'returns true if all element of an array equal to 4' do
      expect([4, 4, 4, 4, 4].my_all?(4)).to eq(true)
    end

    it 'returns true if regex matches all element of an array' do
      expect(%w[12x 4x xy].my_all?(/x/)).to eq(true)
    end
  end

  describe '#my_any?' do
    it 'returns true if any element of my_array is equal to 3' do
      expect(my_array.my_any? { |x| x == 3 }).to eq(true)
    end

    it 'returns true  if any element of an array is true ' do
      expect([true, 1, false].my_any?).to eq(true)
    end

    it 'returns false for false array' do
      expect([nil, false].my_any?).to eq(false)
    end

    it 'returns true if any element of an array has a datatype of Integer' do
      expect(['rumbi', 3, 3.7].my_any?(Integer)).to eq(true)
    end

    it 'returns true if any element of  my_array equal to 4' do
      expect(my_array.my_any?(4)).to eq(true)
    end

    it 'returns true if regex matches any element of an array' do
      expect(%w[12x 4w zy].my_any?(/x/)).to eq(true)
    end
  end

  describe '#my_none?' do
    it 'returns true if none of the elements of my_array is equal to 6' do
      expect(my_array.my_none? { |x| x == 6 }).to eq(true)
    end

    it 'returns true if none of the elements of an array is true ' do
      expect([nil, false].my_none?).to eq(true)
    end

    it 'returns true if none of the elements of an array has a datatype of Integer' do
      expect(['rumbi', true, 3.7].my_none?(Integer)).to eq(true)
    end

    it 'returns true if none element of my_array equal to 7' do
      expect(my_array.my_none?(7)).to eq(true)
    end

    it 'returns true if regex does not matches any element of an array' do
      expect(%w[12x 4w zy].my_none?(/s/)).to eq(true)
    end
  end

  describe '#my_count' do
    it 'returns the number of elements in an array' do
      expect(my_array.my_count).to eq(5)
    end

    it 'returns the number of elements in an array and matches with the given argument' do
      expect(my_array.my_count(4)).to eq(1)
    end

    it 'returns the number of elements based on the condition in an array' do
      expect(my_array.my_count { |x| x > 2 }).to eq(3)
    end
  end

  describe '#my_map' do
    it 'returns enumerable when no block and proc is provided' do
      expect(my_array.my_map).to be_a Enumerable
    end

    it 'returns array bases upon condition in given block' do
      expect(my_array.my_map { |x| x > 3 }).to eq([false, false, false, true, true])
    end

    it 'returns array bases upon condition in given proc' do
      expect(my_array.my_map(&my_proc)).to eq([true, true, false, false, false])
    end
  end

  describe '#my_inject' do
    it 'multiplies the elements of the my_array when :* symbol passed in argument' do
      expect(my_array.my_inject(:*)).to eql(120)
    end

    it 'multiplies the elements of the my_array when accumilator and :* symbol passed in argument' do
      expect(my_array.my_inject(2, :*)).to eql(240)
    end

    it 'returns the sum of elements of my_array' do
      expect(my_array.my_inject { |acc, n| acc + n }).to eql(15)
    end

    it 'returns the sum of elements of my_array adding preset accumilator in argument' do
      expect(my_array.my_inject(5) { |acc, n| acc + n }).to eql(20)
    end

    it 'returns the sum of elements of my_array adding preset accumilator in argument' do
      expect { my_array.my_inject }.to raise_error(LocalJumpError)
    end
  end

  describe '#multiply_els' do
    it 'multiplies all element of array and return it' do
      expect(multiply_els([1, 2, 3, 4])).to eql(24)
    end
  end
end
