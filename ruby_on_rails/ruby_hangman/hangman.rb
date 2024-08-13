require "json"

class Hangman
  attr_reader :secret_word, :letters
  attr_accessor :guesses, :remaining_guesses

  class << self
    def call
      puts "Start a new game (1) or load the previously saved game (2)"

      case gets.chomp.to_i
      when 1 then from_dictionary.call
      when 2 then from_json.call
      else
        puts "Unrecognised input"
        call
      end
    end

    def from_dictionary
      dictionary = "google-10000-english-no-swears.txt"
      words = File.readlines(dictionary).select! { |word| (6..13).cover?(word.length) }

      new(
        secret_word: words.shuffle.pop.upcase.chomp
      )
    end

    def from_json
      filename = "saved_games/last_game.json"
      data = JSON.parse(File.read(filename))

      new(
        secret_word: data["secret_word"],
        guesses: data["guesses"],
        remaining_guesses: data["remaining_guesses"]
      )
    end
  end

  def initialize(secret_word:, guesses: [], remaining_guesses: 5)
    @secret_word = secret_word
    @letters = secret_word.chars
    @guesses = guesses
    @remaining_guesses = remaining_guesses

    puts "Hangman initialised"
  end

  def call
    until solved? || failed?
      show_current_game_state

      collect_user_input
    end

    puts "You #{solved? ? "Win!" : "Lose!"} The word was #{secret_word}"
  end

  private

  def solved?
    (letters.uniq.sort - guesses.uniq.sort).empty?
  end

  def failed?
    remaining_guesses.zero?
  end

  def show_current_game_state
    puts letters.map { |letter| guesses.include?(letter) ? letter : "_" }.join(" ")
    puts "Letters Used: #{guesses.sort.uniq.join(" ")}"
    puts "Remaining guesses: #{remaining_guesses}"
  end

  def collect_user_input
    puts "Guess a letter or type SAVE to save and exit"
    user_input = gets.chomp.upcase

    if user_input == "SAVE"
      save_current_game
      exit
    elsif valid_guess?(user_input)
      guesses << user_input
    end

    @remaining_guesses -= 1 unless letters.include?(user_input)
    puts
  end

  def valid_guess?(letter)
    ("A".."Z").cover?(letter)
  end

  def save_current_game
    Dir.mkdir("saved_games") unless Dir.exist?("saved_games")
    filename = "saved_games/last_game.json"

    File.open(filename, "w") do |file|
      file.puts(to_json)
    end
  end

  def to_json
    JSON.dump(
      {
        secret_word: @secret_word,
        guesses: @guesses,
        remaining_guesses: @remaining_guesses
      }
    )
  end
end

Hangman.call
