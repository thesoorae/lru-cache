require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map[key]
      link = @map[key]
      update_link!(link)
      return link.val
    else
      val = @prc.call(key)
      newlink = @store.insert(key, val)
      @map[key] = newlink

      if self.count > @max
        removeLink = @store.first
        removeLink.prev.next = removeLink.next
        removeLink.next.prev = removeLink.prev
        
        @map.delete(removeLink.key)
      end
      return val
    end

  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    return @prc.call(key)
    # suggested helper method; insert an (un-cached) key
  end

  def update_link!(link)
    link.prev.next = link.next
    link.next.prev = link.prev

    link.prev = @store.last
    link.next = @store.last.next
    @store.last.next = link
    # suggested helper method; move a link to the end of the list
  end

  def eject!
  end
end
