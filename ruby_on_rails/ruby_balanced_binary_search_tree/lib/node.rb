class Node
  attr_accessor :data, :left_child, :right_child

  def initialize(data:, left_child: nil, right_child: nil)
    @data = data
    @left_child = left_child
    @right_child = right_child
  end

  def leaf?
    left_child.nil? && right_child.nil?
  end

  def to_s
    {
      data: data,
      left_child: left_child&.data,
      right_child: right_child&.data
    }
  end
end
