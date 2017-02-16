
class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Link.new()
    @tail = Link.new()
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link| return link if i == j }
    nil
  end

  def first
    return nil if self.empty?
    @head.next
  end

  def last
    return nil if self.empty?
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
      unless self.empty?
        self.each do |link|
          return link.val if link.key == key
        end
      end
  end



  def include?(key)
    unless self.empty?
      self.each do |link|
        return true if link.key == key
      end
    end
    return false
  end

  def insert(key, val)
    if self.include?(key)
      self.each do |link|
        link.val = val if link.key == key
      end
    else
      newLink = Link.new(key, val)
      newLink.prev = @tail.prev
      newLink.next = @tail
      @tail.prev.next = newLink
      @tail.prev = newLink
    end
  end

  def remove(key)
    unless self.empty?
      self.each do |link|
        if link.key == key
          link.prev.next = link.next unless link.prev == nil
          link.next.prev = link.prev unless link.next == nil
          link.key = nil
          link.val = nil
        end
      end
    end
  end

  def each
    return [] if self.empty?
    current_link = @head.next
    until current_link.next == nil do
      yield current_link
      current_link = current_link.next
    end

  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end

end
