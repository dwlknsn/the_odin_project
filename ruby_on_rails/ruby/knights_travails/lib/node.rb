class Node
  attr_accessor :x, :y, :next_node

  def initialize(x, y, next_node = nil)
    @x = x
    @y = y
    @next_node = next_node
  end

  def to_s
    {
      position: position,
      next_node: next_node
    }
  end

  def position
    [x, y]
  end
end
