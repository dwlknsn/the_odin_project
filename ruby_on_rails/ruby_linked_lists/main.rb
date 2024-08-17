require_relative "linked_list"

list = LinkedList.new

# list.append(value) adds a new node containing value to the end of the list
list.append("dog")
list.append("cat")
list.append("parrot")
list.append("hamster")

expected = "( dog ) -> ( cat ) -> ( parrot ) -> ( hamster ) -> nil"
actual = list.to_s
puts "list.append test PASSED" if expected == actual

# list.prepend(value) adds a new node containing value to the start of the list
list.prepend("turtle")
list.prepend("snake")

expected = "( snake ) -> ( turtle ) -> ( dog ) -> ( cat ) -> ( parrot ) -> ( hamster ) -> nil"
actual = list.to_s
puts "list.prepend test PASSED" if expected == actual

# list.size returns the total number of nodes in the list
expected = 6
actual = list.size
puts "list.size test PASSED" if expected == actual

# list.head returns the first node in the list
expected = "snake"
actual = list.head.value
puts "list.head test PASSED" if expected == actual

# list.tail returns the last node in the list
expected = "hamster"
actual = list.tail.value
puts "list.tail test PASSED" if expected == actual

# list.at(index) returns the node at the given index
expected = "dog"
actual = list.at(2).value
puts "list.at test PASSED" if expected == actual


# list.pop removes the last element from the list
list.pop
list.pop

expected = "( snake ) -> ( turtle ) -> ( dog ) -> ( cat ) -> nil"
actual = list.to_s
puts "list.pop test PASSED" if expected == actual


# list.contains?(value) returns true if the passed in value is in the list and otherwise returns false.
expected = true
actual = list.contains?("cat")
puts "list.contains? truthy test PASSED" if expected == actual

expected = false
actual = list.contains?("fox")
puts "list.contains? falsy test PASSED" if expected == actual


# list.find(value) returns the index of the node containing value, or nil if not found.

expected = 3
actual = list.find("cat")
puts "list.find truthy test PASSED" if expected == actual

expected = nil
actual = list.find("fox")
puts "list.find falsy test PASSED" if expected == actual

# list.to_s represent your LinkedList
expected = "( snake ) -> ( turtle ) -> ( dog ) -> ( cat ) -> nil"
actual = list.to_s
puts "list.to_s test PASSED" if expected == actual
