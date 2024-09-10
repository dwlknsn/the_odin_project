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

  left_arr.each do |l|
    right_arr.each_with_index do |r, j|
      next if r.nil?

      if r <= l
        sorted_arr << r
        right_arr[j] = nil
      else
        break
      end
    end
    sorted_arr << l
  end

  # merge any remaining elements from the right array
  sorted_arr.concat(right_arr).compact
end

### TEST ###
3.times do
  array = Array.new(20) { Random.rand(100) }

  result = merge_sort(array)
  expected = array.sort

  puts (result == expected) ? "Test PASSED" : "Test FAILED"
end
