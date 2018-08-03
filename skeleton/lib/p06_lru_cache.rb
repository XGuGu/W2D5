require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

require 'byebug'
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
    # debugger
    if map.include?(key)
      update_node!(map[key])
    else
      calc!(key)
      eject!
    end

    map[key].val
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  attr_reader :map, :store, :max, :prc

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    value = prc.call(key)
    node = store.append(key, value)
    map.set(key, node)
  end

  def update_node!(node)
    # suggested helper method; move a node to the end of the list
    node.remove
    node = store.append(node.key, node.val)
    map.set(node.key, node)
  end

  def eject!
    #check max
    if count > max
      node = store.first
      map.delete(node.key)
      node.remove
    end
  end
end
