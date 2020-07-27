require_relative '../enumerables.rb'

describe Enumerable do
  let(:my_array) { [1, 2, 3, 4, 5] }
  let(:my_hash) { { a: 1, b: 2 } }

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
      my_array.my_each { |x| sum = x + sum}
      expect(sum).to eq(15)
    end
    
  end

  describe '#my_each_with_index' do
    it 'iterates to entire array of numbers and return array' do
      expect(my_array.my_each_with_index { |x,y| x }).to eq([1, 2, 3, 4, 5])
    end

    it 'iterates to range of numbers and return range' do
      expect((1..5).my_each_with_index { |x,y| x }).to eq(1..5)
    end

    it 'it returns enumerable when no block is passed' do
      expect((1..5).my_each_with_index).to be_a Enumerable
    end

    it 'it iterates through hash and it returns hash' do
      expect(my_hash.my_each_with_index { |x,y| x }).to eq({ a: 1, b: 2 })
    end

    it 'calculate sum for each element of an array' do
      sum = 0 
      my_array.my_each_with_index { |x,y| sum = y + sum}
      expect(sum).to eq(10)
    end
  end

  describe '#my_select' do
    it 'selects an item in the array and returns true' do
      expect(my_array.my_select { |x| x > 3}).to eq([4,5])
    end

    it 'returns enumerable when no block is given' do
      expect(my_array.my_select).to be_a Enumerable
    end
  end


end
