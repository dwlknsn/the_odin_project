require_relative "node"

class LinkedList
  attr_accessor :head

  def tail
    current_node = head

    until current_node.next_node.nil?
      current_node = current_node.next_node
    end

    current_node
  end

  def append(value)
    new_node = Node.new(value: value)

    if head.nil?
      @head = new_node
    else
      tail.next_node = new_node
    end
  end

  def prepend(value)
    prev_head = head
    @head = Node.new(value: value, next_node: prev_head)
  end

  def size
    return 0 if head.nil?

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
      current_node = current_node.next_node
    end

    current_node
  end

  def pop
    return "EMPTY LIST" if head.nil?

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

  def contains?(value)
    current_node = head

    until current_node.nil?
      return true if current_node.value == value

      current_node = current_node.next_node
    end

    false
  end

  def find(value)
    current_node = head
    index = 0

    until current_node.nil?
      return index if current_node.value == value

      index += 1
      current_node = current_node.next_node
    end
  end

  def to_s
    output = ""
    current_node = head

    until current_node.nil?
      output += "( #{current_node.value} ) -> "
      current_node = current_node.next_node
    end

    output + "nil"
  end

  def insert_at(value, target_index)
    current_node = head
    index = 0

    until index == target_index
      return "Invalid target index" if current_node.next_node.nil?

      index += 1
      prev_node = current_node
      current_node = current_node.next_node
    end

    prev_node.next_node = Node.new(value: value, next_node: current_node)
  end

  def remove_at(target_index)
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
end
