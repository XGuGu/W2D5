class StaticArray
  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    @store[i]
  end

  def []=(i, val)
    validate!(i)
    @store[i] = val
  end

  def length
    @store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, @store.length - 1)
  end
end

class DynamicArray
  include Enumerable
  attr_accessor :count

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
  end

  def [](i)
    store[i]
  end

  def []=(i, val)
    store[i] = val
  end

  def capacity
    @store.length
  end

  def include?(val)
    i = 0

    while i < capacity
      return true if store[i] == val
      i += 1
    end

    false
  end

  def push(val) #with the check for resiing! count += 1
    count += 1
    index = 0
    i = capacity - 1

    while i >= 0
      index = i unless store[i].nil?
      i -= 1
    end
    resi
    store[index + 1] = val

  end

  def unshift(val) #with the check for resiing! count += 1

  end

  def pop
  end

  def shift
    return_val = self.first
    i = 1

    while i < capacity
      store[i - 1] = store[i]
      i += 1
    end
    store[i - 1] = nil
    count -= 1 if count > 0
    return_val
  end

  def first
    i = 0

    while i < capacity
      return store[i] unless store[i].nil?
      i += 1
    end

    nil
  end

  def last
    i = capacity - 1

    while i >= 0
      return store[i] if store[i]
      i -= 1
    end

    nil
  end

  def each
    i = 0

    while i < capacity
      yield(store[i]) if store[i]
      i += 1
    end

    self
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    # ...
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  attr_reader :store

  def resize!
  end
end
