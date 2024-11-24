def merge_sort(arr)
  # base cases
  return arr if arr.length <= 1

  # recursion
  # split the unsorted array into left and right halves
  left, right = arr.each_slice((1 + arr.length) / 2).to_a

  # sort each half recursively
  sorted_left = merge_sort(left)
  sorted_right = merge_sort(right)

  # merge the two sorted halves
  merge(sorted_left, sorted_right)
end

def merge(left_arr, right_arr)
  sorted_arr = []

  left_arr.each do |left|
    right_arr.each_with_index do |right, i|
      next if right.nil?
      break if right > left

      sorted_arr << right
      right_arr[i] = nil
    end
    sorted_arr << left
  end

  # merge any remaining elements from the right array
  # and remove any nil values
  sorted_arr.concat(right_arr).compact
end

### TEST ###
5.times do
  array = Array.new(10) { Random.rand(100) }

  result = merge_sort(array)
  expected = array.sort

  output = <<~RESULT
    Input:    #{array}
    Expected: #{expected}
    Result:   #{result}
    #{(result == expected) ? "Test PASSED" : "Test FAILED"}

  RESULT

  print output
end
