require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_accessor :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    index = key.hash % store.length
    store[index].include?(key)
  end

  def set(key, val)
    index = key.hash % store.length

    if include?(key)
      store[index].update(key, val)
    else
      self.count += 1
      resize! if count >= store.length
      store[index].append(key, val)
    end
  end

  def get(key)
    return unless include?(key)
    index = key.hash % store.length
    store[index].get(key)
  end

  def delete(key)
    return unless include?(key)
    self.count -= 1
    index = key.hash % store.length
    store[index].remove(key)
  end

  def each
    store.each do |bucket|
      bucket.each do |node|
        yield(node.key, node.val)
      end
    end

    self
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  attr_accessor :store

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(count * 2) { LinkedList.new }

    store.each do |bucket|
      bucket.each do |node|
        key = node.key
        val = node.val
        node.remove
        index = key.hash % new_store.length
        new_store[index].append(key, val)
      end
    end

    self.store = new_store
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
  end
end
