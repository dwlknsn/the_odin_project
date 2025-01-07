def substrings(target_string, dictionary = [])
  sanitized_string = target_string.downcase.gsub(/[^\w\s]/, "")
  dictionary.map.with_object(Hash.new(0)) do |word, h|
    h[word] = sanitized_string.scan(word).count
  end.select{|k, v| v > 0}
end
