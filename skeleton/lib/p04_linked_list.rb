class Node
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

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.

    self.prev.next = self.next
    self.next.prev = self.prev
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Node.new("head", "head")
    @tail = Node.new("tail", "tail")
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    head.next
  end

  def last
    tail.prev
  end

  def empty?
    head.next == tail && tail.prev == head
  end

  def get(key)
    node = head.next

    until node == tail
      return node.val if node.key == key
      node = node.next
    end

    nil
  end

  def include?(key)
    !get(key).nil?
  end

  def append(key, val)
    node = Node.new(key, val)
    tail.prev.next = node
    node.prev = tail.prev
    node.next = tail
    tail.prev = node
  end

  def update(key, val)
    node = head.next

    until node == tail
      if node.key == key
        node.val = val
      end

      node = node.next
    end
  end

  def remove(key)
    node = head.next

    until node == tail
      if node.key == key
        node.remove
      end

      node = node.next
    end
  end

  def each
    node = head.next

    until node == tail
      yield(node)

      node = node.next
    end

    self
  end

  private

  attr_reader :head, :tail

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
