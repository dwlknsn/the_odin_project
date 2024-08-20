require_relative "node"

class LinkedList
  attr_accessor :head

  def tail
    return if empty?

    current_node = head

    until current_node.next_node.nil?
      current_node = current_node.next_node
    end

    current_node
  end

  def append(key, value)
    new_node = Node.new(key: key, value: value)

    if empty?
      @head = new_node
    else
      tail.next_node = new_node
    end
  end

  def prepend(key, value)
    prev_head = head
    @head = Node.new(key: key, value: value, next_node: prev_head)
  end

  def size
    return 0 if empty?

    counter = 1
    current_node = head

    until current_node.next_node.nil?
      counter += 1
      current_node = current_node.next_node
    end

    counter
  end

  def at(index)
    current_node = head

    index.times do
      return nil if current_node.nil? # End of list reached before Node at target index found

      current_node = current_node.next_node
    end

    current_node
  end

  def pop
    return if empty?

    if head.next_node.nil?
      @head = nil
    else
      current_node = head

      until current_node.next_node.nil?
        prev_node = current_node
        current_node = current_node.next_node
      end

      prev_node.next_node = nil
    end
  end

  def contains?(key)
    current_node = head

    until current_node.nil?
      return true if current_node.key == key

      current_node = current_node.next_node
    end

    false
  end

  def find(key)
    current_node = head
    index = 0

    until current_node.nil?
      return index if current_node.key == key

      index += 1
      current_node = current_node.next_node
    end
  end

  def to_s
    return if empty?

    output = ""
    current_node = head

    until current_node.nil?
      output += "( #{current_node.key}:#{current_node.value} ) -> "
      current_node = current_node.next_node
    end

    output + "nil"
  end

  def insert_at(key, value, target_index)
    if empty?
      if target_index.zero?
        @head = Node.new(key: key, value: value)
      end
      return
    end

    current_node = head
    index = 0

    until index == target_index
      return if current_node.next_node.nil?

      index += 1
      prev_node = current_node
      current_node = current_node.next_node
    end

    prev_node.next_node = Node.new(key: key, value: value, next_node: current_node)
  end

  def remove_at(target_index)
    return if empty?

    if target_index == 0
      @head = head.next_node
      return
    end

    current_node = head
    index = 0

    until index == target_index
      return "Invalid target index" if current_node.next_node.nil?

      index += 1
      prev_node = current_node
      current_node = current_node.next_node
    end

    prev_node.next_node = current_node.next_node
  end

  def empty?
    head.nil?
  end

  def empty!
    @head = nil
  end

  def keys
    current_node = head
    arr = []

    until current_node.nil?
      arr << current_node.key
      current_node = current_node.next_node
    end

    arr
  end

  def values
    current_node = head
    arr = []

    until current_node.nil?
      arr << current_node.value
      current_node = current_node.next_node
    end

    arr
  end

  def entries
    current_node = head
    arr = []

    until current_node.nil?
      arr << [current_node.key, current_node.value]
      current_node = current_node.next_node
    end

    arr
  end
end
