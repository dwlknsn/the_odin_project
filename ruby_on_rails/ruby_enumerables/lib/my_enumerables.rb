module Enumerable
  # Your code goes here
  def my_all?
    self.each { |elem| return false unless yield(elem) }

    true
  end

  def my_any?
    self.each { |elem| return true if yield(elem) }

    false
  end

  def my_count
    if block_given?
      self.select { |elem| yield(elem) }.size
    else
      self.size
    end
  end

  def my_each_with_index
    if block_given?
      index = 0
      self.each { |elem| yield(elem, index); index += 1 }
    end
  end

  def my_inject(memo)
    if block_given?
      self.each {|elem| memo = yield(memo, elem)}
      memo
    end
  end

  def my_map
    if block_given?
      new_arr = []
      self.each { |elem| new_arr << yield(elem) }
      new_arr
    end
  end

  def my_none?
    self.select { |elem| yield(elem) }.empty?
  end

  def my_select
    new_arr = []
    self.each { |elem| new_arr << elem if yield(elem) }
    new_arr
  end
end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  # Define my_each here
  def my_each
    self.each { |elem| yield(elem) }
  end
end
