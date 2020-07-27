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
  end
end
