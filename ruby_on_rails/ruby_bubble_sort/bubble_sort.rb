def bubble_sort(array, iteration_count = 1)
  # p "initial: #{array}"
  return array if iteration_count >= array.length

  flipped = false

  array.each_with_index do |el, i|
    next if i >= (array.length - iteration_count)

    next_el = array[i + 1]

    if el > next_el
      flipped = true
      array[i] = next_el
      array[i + 1] = el
    end
  end

  bubble_sort(array, iteration_count + 1) if flipped

  array
end
