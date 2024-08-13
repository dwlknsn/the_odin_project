class Hangman
  attr_reader :secret_word, :letters
  attr_accessor :guesses, :remaining_guesses

  def initialize(dictionary = "google-10000-english-no-swears.txt")
    words = File.readlines(dictionary).select! { |word| (6..13).cover?(word.length) }
    @secret_word = words.shuffle.pop.upcase.chomp
    @letters = secret_word.chars

    @guesses = []
    @remaining_guesses = 5

    puts "Hangman initialised"
  end

  def call
    until solved? || failed?
      puts "Remaining guesses: #{remaining_guesses}"
      puts "Letters Used: #{guesses.sort.uniq.join(" ")}"

      puts "Guess a letter"
      guess = gets.chomp.upcase
      guesses << guess if valid_guess?(guess)

      @remaining_guesses -= 1 unless letters.include?(guess)

      puts letters.map { |letter| guesses.include?(letter) ? letter : "_" }.join(" ")
    end

    if solved?
      puts "You Win!"
    else
      puts "You Lose! The word was #{secret_word}"
    end
  end

  private

  def solved?
    (letters.uniq.sort - guesses.uniq.sort).empty?
  end

  def failed?
    remaining_guesses.zero?
  end

  def valid_guess?(letter)
    ("A".."Z").cover?(letter)
  end
end

Hangman.new.call
