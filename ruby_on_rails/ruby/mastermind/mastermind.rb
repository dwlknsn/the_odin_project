module Mastermind
  MAX_ATTEMPTS = 10
  PEGS = %w[1 2 3 4 5 6]
  SECRET_CODE_LENGTH = 4

  class Player
    attr_reader :name

    def initialize(name)
      @name = name
      @guesses = []
      @scores = []
    end
  end

  class HumanPlayer < Player
    attr_accessor :scores

    def get_secret_code
      print "Enter code:\t"
      gets.chomp.upcase.chars
    end
    alias_method :get_guess, :get_secret_code
  end

  class ComputerPlayer < Player
    attr_accessor :guesses, :scores
    attr_reader :mode

    def initialize(name = "MegaBot5000", mode = :algo)
      @name = name
      @mode = mode

      # Seed all possible solutions and scores up front
      @remaining_solutions = PEGS.repeated_permutation(SECRET_CODE_LENGTH).to_a
      @all_scores = Hash.new { |h, k| h[k] = {} }
      @remaining_solutions.product(@remaining_solutions).each do |guess, answer|
        @all_scores[guess][answer] = GuessChecker.new(guess, answer).calculate_score
      end
    end

    def get_secret_code
      Array.new(SECRET_CODE_LENGTH) { PEGS.sample }
    end

    def get_guess
      guess = nil

      loop do
        guess = case mode
        when :algo then algo_guess
        else
          random_guess
        end

        unless guesses.include?(guess)
          guesses << guess
          break
        end
      end

      puts "Computer guesses code: #{guess.join}"
      guess
    end

    private

    def algo_guess
      if guesses.empty?
        %w[1 1 2 2]
      else

        @remaining_solutions.keep_if do |solution|
          @all_scores[guesses.last][solution] == scores.last
        end

        puts "REMAINING SOLUTIONS: #{@remaining_solutions.count}"

        @all_scores.keep_if do |guess, _scores_by_answer|
          @remaining_solutions.include?(guess)
        end

        possible_guesses = @all_scores.map do |guess, scores_by_answer|
          scores_by_answer = scores_by_answer.select do |answer, score|
            @remaining_solutions.include?(answer)
          end
          @all_scores[guess] = scores_by_answer

          score_groups = scores_by_answer.values.group_by(&:itself)
          possibility_counts = score_groups.values.map(&:length)
          worst_case_possibilities = possibility_counts.max
          [worst_case_possibilities, guess]
        end

        possible_guesses.min.last
      end
    end

    def random_guess
      Array.new(SECRET_CODE_LENGTH) { PEGS.sample }
    end
  end

  class GuessChecker
    attr_reader :secret_code, :guess

    def initialize(secret_code, guess)
      @secret_code = secret_code
      @guess = guess
    end

    def calculate_score
      a = secret_code.dup
      b = guess.dup
      score = ""

      a.each_with_index do |char, i|
        next unless char == b[i]

        a[i] = b[i] = "*"
        score << "✅"
      end

      a.each do |char|
        next if char == "*"

        if b.include?(char)
          score << "🟨"
          b[b.index(char)] = "?"
        end
      end

      score
    end
  end

  class Game
    class << self
      def start(human_player, computer_player)
        print_game_intro
        get_player_roles(human_player, computer_player)
      end

      def print_game_intro
        puts <<~INTRO
          ~~~ MASTERMIND ~~~

          The Codemaker will create a #{SECRET_CODE_LENGTH} character code from the following options: #{PEGS.join}
          The Codebreaker has #{MAX_ATTEMPTS} attempts to find the code

          Each guess will receive feedback as follows:

          ✅ = You have a peg with the correct color in the correct position
          🟨 = You have a peg with the correct color in the wrong position

          Let's Play!

        INTRO
      end

      def get_player_roles(human_player, computer_player)
        puts <<~PLAYER_ROLE
          Which role do you want to play?
            [1] CODEBREAKER
            [2] CODEMAKER
        PLAYER_ROLE

        case gets.chomp.to_i
        when 1
          puts "You selected CODEBREAKER"
          new(computer_player, human_player).start
        when 2
          puts "You selected CODEMAKER"
          new(human_player, computer_player).start
        end
      end
    end

    def initialize(codemaker, codebreaker)
      @codemaker = codemaker
      @codebreaker = codebreaker
      @remaining_attempts = MAX_ATTEMPTS
      @secret_code = generate_secret_code
    end

    def start
      loop do
        self.remaining_attempts -= 1

        get_codebreaker_guess
        check_for_winner
        check_for_out_of_attempts
      end
    end

    private

    attr_accessor :current_guess, :remaining_attempts
    attr_reader :codemaker, :codebreaker, :secret_code

    def generate_secret_code
      code = codemaker.get_secret_code

      while invalid_code?(code)
        puts "Invalid. Please re-enter code."
        code = codemaker.get_secret_code
      end

      code
    end

    def get_codebreaker_guess
      guess = codebreaker.get_guess

      while invalid_code?(guess)
        puts "Invalid. Please guess again."
        guess = codebreaker.get_guess
      end

      self.current_guess = guess
    end

    def invalid_code?(code)
      # require "pry-byebug"; binding.pry
      code.length != SECRET_CODE_LENGTH || code.any? { |char| !PEGS.include?(char) }
    end

    def check_for_winner
      puts score = get_score
      codebreaker.scores << score

      if score == "✅" * SECRET_CODE_LENGTH
        puts "\n\tWINNER!!!"
        game_over
      else
        puts "\nRemaining attempts: #{remaining_attempts}"
      end
    end

    def get_score
      GuessChecker.new(secret_code, current_guess).calculate_score
    end

    def check_for_out_of_attempts
      return if remaining_attempts > 0

      game_over
    end

    def game_over
      puts  "\nThe secret code was #{secret_code.join}\n"
      puts "\n\t~~~ GAME OVER ~~~"
      exit
    end
  end
end
