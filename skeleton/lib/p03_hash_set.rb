class HashSet
  attr_accessor :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    return false if include?(key)
    self.count += 1
    resize! if count >= store.length
    index = key.hash % store.length
    store[index] << key
  end

  def include?(key)
    index = key.hash % store.length
    store[index].include?(key)
  end

  def remove(key)
    return unless include?(key)
    self.count -= 1
    index = key.hash % store.length
    store[index].delete(key)
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
        index = element.hash % store.length
        store[index] << element
      end
    end
  end
end
