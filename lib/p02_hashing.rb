class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    sum = 0;
    self.each do |el|
      sum += sum + el.hash
    end
    sum += self.length
    sum.hash
  end
end

class String
  def hash
    str_arr = self.chars.map(&:ord)
    str_arr.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    hash_arr = self.to_a
    hash_arr.sort! do |a,b|
      a[0] <=> b[0]
    end
    hash_arr.map! do |sub_arr|
      sub_arr.hash
    end
    hash_arr.hash


  end
end
