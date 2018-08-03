class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    code = 100
    self.each_with_index do |el, i|
      code += el.to_s.hash ^ i
    end
    code
  end
end

class String
  def hash
    code = 100
    self.chars.each_with_index do |ch, i|
      code += ch.ord ^ i
    end
    code
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    self.to_a.sort_by {|arr| arr.hash }.hash
  end
end
