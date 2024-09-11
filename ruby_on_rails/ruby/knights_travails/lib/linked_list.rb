require_relative "node"

class LinkedList
  attr_accessor :head

  def tail
    return if head.nil?

    current_node = head

    until current_node.next_node.nil?
      current_node = current_node.next_node
    end

    current_node
  end

  def append(node)
    if head.nil?
      @head = node
    else
      tail.next_node = node
    end

    self
  end

  def contains?(position)
    current_node = head

    until current_node.nil?
      return true if current_node.position == position

      current_node = current_node.next_node
    end

    false
  end

  def duplicate
    return if head.nil?

    new_list = LinkedList.new.append(Node.new(head.x, head.y))

    current_node = head.next_node

    until current_node.nil?
      new_list.append(Node.new(current_node.x, current_node.y))
      current_node = current_node.next_node
    end

    new_list
  end

  def to_s
    return if head.nil?

    output = []
    current_node = head

    until current_node.nil?
      output << current_node.position.to_s
      current_node = current_node.next_node
    end

    output.join(" -> ")
  end
end
