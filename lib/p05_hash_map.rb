require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  attr_reader :count
  include Enumerable

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    i = bucket(key)
    @store[i].include?(key)
  end

  def set(key, val)

    @count += 1 unless self.include?(key)
    resize! if @count > @store.length
    i = bucket(key)
    @store[i].insert(key, val)
  end

  def get(key)
    i = bucket(key)
    @store[i].get(key)
  end

  def delete(key)
    @count -= 1
    i = bucket(key)
    @store[i].remove(key)
  end

  def each




  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    num_buckets = @store.length * 2
    newstore = Array.new(num_buckets){LinkedList.new}
    @store.each do |list|
      list.each do |el|
        i = el.key.hash % newstore.length
        newstore[i].insert(el.key, el.val)
      end
    end
    @store = newstore
  end

  def bucket(key)
    num = key.hash
    bucket = num % @store.length

    # optional but useful; return the bucket corresponding to `key`
  end
end
