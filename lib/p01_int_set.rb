class MaxIntSet
  def initialize(max)

    @store = Array.new(max, false)
  end

  def insert(num)
    validate!(num)
    @store[num] = true
  end

  def remove(num)
    validate!(num)
    @store[num] = false
  end

  def include?(num)
    validate!(num)
    @store[num]
  end

  private

  def is_valid?(num)
    num > 0 && num < @store.length
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
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
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    @count +=1
    resize! if @count == @store.length
    self[num] << num
  end

  def remove(num)
    if self.include?(num)
      @count -= 1
      self[num].delete(num)
    end

  end

  def include?(num)
    self[num].include?(num)

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
