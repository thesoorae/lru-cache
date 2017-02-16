require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    num = key.hash
    @count +=1
    resize! if @count == @store.length
    self[num] << num
  end

  def include?(key)
    num = key.hash
    self[num].include?(num)

  end

  def remove(key)
    num = key.hash
    if self.include?(key)
      @count -= 1
      self[num].delete(num)

    end
  end

  private

  def [](num)
    bucket = num % @store.length
    @store[bucket]
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    num_buckets = @store.length * 2
    newstore = Array.new(num_buckets){Array.new}
    allvals = @store.flatten
    allvals.each_with_index do |el|
      newstore[ el % num_buckets].push(el)
    end
    @store = newstore
  end
end
