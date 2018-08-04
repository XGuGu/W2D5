class MaxIntSet
  def initialize(max)
    @store = Array.new(max, false)
    @size = max
  end

  def insert(num)
    validate!(num)
    store[num] = true
  end

  def remove(num)
    validate!(num)
    store[num] = false
  end

  def include?(num)
    validate!(num)
    store[num]
  end

  private

  attr_reader :store, :size

  def is_valid?(num)
    num.between?(0, @size - 1)
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(ele)
    index = ele % store.length
    store[index] << ele
  end

  def remove(ele)
    index = ele % store.length
    store[index].delete(ele)
  end

  def include?(ele)
    index = ele % store.length
    store[index].include?(ele)
  end

  private

  attr_reader :store

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_accessor :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(ele)
    return false if include?(ele)
    self.count += 1
    resize! if count >= store.length
    index = ele % store.length
    store[index] << ele
  end

  def remove(ele)
    return unless include?(ele)
    self.count -= 1
    index = ele % store.length
    store[index].delete(ele)
  end

  def include?(ele)
    index = ele % store.length
    store[index].include?(ele)
  end

  private

  attr_reader :store

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    count.times do
      store << Array.new
    end

    store.each do |bucket|
      bucket.length.times do
        element = bucket.shift
        index = element % store.length
        store[index] << element
      end
    end
  end
end

#zhanglingjiedahuaidan
