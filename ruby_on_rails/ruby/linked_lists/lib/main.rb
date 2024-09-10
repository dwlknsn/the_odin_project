require_relative "linked_list"

list = LinkedList.new

# list.append(value) adds a new node containing value to the end of the list
list.append("dog")
list.append("cat")
list.append("parrot")
list.append("hamster")

expected = "( dog ) -> ( cat ) -> ( parrot ) -> ( hamster ) -> nil"
actual = list.to_s
if expected == actual
  puts "✅ list.append test PASSED"
else
  puts "❌ list.append test FAILED"
end

# list.prepend(value) adds a new node containing value to the start of the list
list.prepend("turtle")
list.prepend("snake")

expected = "( snake ) -> ( turtle ) -> ( dog ) -> ( cat ) -> ( parrot ) -> ( hamster ) -> nil"
actual = list.to_s
if expected == actual
  puts "✅ list.prepend test PASSED"
else
  puts "❌ list.prepend test FAILED"
end

# list.size returns the total number of nodes in the list
expected = 6
actual = list.size
if expected == actual
  puts "✅ list.size test PASSED"
else
  puts "❌ list.size test FAILED"
end

# list.head returns the first node in the list
expected = "snake"
actual = list.head.value
if expected == actual
  puts "✅ list.head test PASSED"
else
  puts "❌ list.head test FAILED"
end

# list.tail returns the last node in the list
expected = "hamster"
actual = list.tail.value
if expected == actual
  puts "✅ list.tail test PASSED"
else
  puts "❌ list.tail test FAILED"
end

# list.at(index) returns the node at the given index
expected = "dog"
actual = list.at(2).value
if expected == actual
  puts "✅ list.at test PASSED"
else
  puts "❌ list.at test FAILED"
end


# list.pop removes the last element from the list
list.pop
list.pop

expected = "( snake ) -> ( turtle ) -> ( dog ) -> ( cat ) -> nil"
actual = list.to_s
if expected == actual
  puts "✅ list.pop test PASSED"
else
  puts "❌ list.pop test FAILED"
end


# list.contains?(value) returns true if the passed in value is in the list and otherwise returns false.
expected = true
actual = list.contains?("cat")
if expected == actual
  puts "✅ list.contains? truthy test PASSED"
else
  puts "❌ list.contains? truthy test FAILED"
end

expected = false
actual = list.contains?("fox")
if expected == actual
  puts "✅ list.contains? falsy test PASSED"
else
  puts "❌ list.contains? falsy test FAILED"
end


# list.find(value) returns the index of the node containing value, or nil if not found.

expected = 3
actual = list.find("cat")
if expected == actual
  puts "✅ list.find truthy test PASSED"
else
  puts "❌ list.find truthy test FAILED"
end

expected = nil
actual = list.find("fox")
if expected == actual
  puts "✅ list.find falsy test PASSED"
else
  puts "❌ list.find falsy test FAILED"
end

# list.to_s represent your LinkedList
expected = "( snake ) -> ( turtle ) -> ( dog ) -> ( cat ) -> nil"
actual = list.to_s
if expected == actual
  puts "✅ list.to_s test PASSED"
else
  puts "❌ list.to_s test FAILED"
end

#insert_at(value, index) that inserts a new node with the provided value at the given index.
list.insert_at("warthog", 1)
expected = "( snake ) -> ( warthog ) -> ( turtle ) -> ( dog ) -> ( cat ) -> nil"
actual = list.to_s
if expected == actual
  puts "✅ list.insert_at test PASSED"
else
  puts "❌ list.insert_at test FAILED"
end

#remove_at(index) that removes the node at the given index.
list.remove_at(2)
expected = "( snake ) -> ( warthog ) -> ( dog ) -> ( cat ) -> nil"
actual = list.to_s

if expected == actual
  puts "✅ list.remove_at test PASSED"
else
  puts "❌ list.remove_at test FAILED"
end
