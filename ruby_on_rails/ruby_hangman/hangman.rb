puts "Hangman initialised"

dictionary = File.readlines("google-10000-english-no-swears.txt")

dictionary.select! { |word| (5..12).cover?(word.length) }

secret_word = dictionary.shuffle.pop.upcase.chomp
letters = secret_word.chars

guesses = []
remaining_guesses = 5

until (letters.uniq.sort - guesses.uniq.sort).empty?
  puts "Remaining guesses: #{remaining_guesses}"
  break if remaining_guesses.zero?

  puts "Guess a letter"
  guess = gets.chomp.upcase
  guesses << guess if ("A".."Z").cover?(guess)

  remaining_guesses -= 1 unless letters.include?(guess)

  letters.each { |letter| print guesses.include?(letter) ? " #{letter} " : " _ " }
  puts
  print "Letters Used: #{guesses.sort.uniq { |guess| " #{guess} " }}"
  puts
end

if remaining_guesses.zero?
  puts "You Lose! The word was #{secret_word}"
else
  puts "You Win!"
end
