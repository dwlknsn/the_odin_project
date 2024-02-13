def substrings(target_string, dictionary = [])
  words = get_words_from(target_string)
  permutations = get_permutations_from(words)

  permutations.each_with_object(Hash.new(0)) do |word, h|
    h[word] += 1 if dictionary.include?(word)
  end
end

def get_words_from(string)
  string.split.map { |word| word.downcase.gsub(/\W/, "") }
end

def get_permutations_from(array_of_words)
  array_of_words.map do |word|
    0.upto(word.length).each_with_object([]) do |n, arr|
      1.upto(word.length - n) do |m|
        arr << word[n, m]
      end

      arr
    end
  end.flatten
end
