module TicTacToe
  class Player
    attr_reader :name
    attr_accessor :marker

    def initialize(name)
      @name = name
    end
  end

  class Game
    MARKERS = %w[O X]
    WINNING_COMBOS = [
      [1, 2, 3], [4, 5, 6], [7, 8, 9],  # horizontal
      [1, 4, 7], [2, 5, 8], [3, 6, 9],  # vertical
      [1, 5, 9], [3, 5, 7]              # diagonal
    ]

    def initialize(players)
      @players = players
      @board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
      @turn_count = 0
    end

    def start
      assign_player_markers

      loop do
        display_board
        place_marker_on_board

        check_for_winner
        check_for_draw

        self.turn_count += 1
      end
    end

    private

    attr_accessor :turn_count
    attr_reader :board, :players

    def assign_player_markers
      players.each_with_index do |player, i|
        player.marker = MARKERS[i]
        puts "#{player.name} is using symbol #{player.marker}"
      end
    end

    def display_board
      puts <<~BOARD

         #{board[0]} | #{board[1]} | #{board[2]}
        ---+---+---
         #{board[3]} | #{board[4]} | #{board[5]}
        ---+---+---
         #{board[6]} | #{board[7]} | #{board[8]}

      BOARD
    end

    def place_marker_on_board
      puts "#{current_player.name} please select a position."
      chosen_position = gets.chomp.to_i - 1 # adjust for 0-indexed array

      while position_taken?(chosen_position)
        puts "Position already taken. Choose again."
        chosen_position = gets.chomp.to_i - 1
      end

      board[chosen_position] = current_player.marker
    end

    def current_player
      players[turn_count % 2]
    end

    def position_taken?(position)
      MARKERS.include?(board[position])
    end

    def check_for_winner
      return unless winner?
      puts "THE WINNER IS #{current_player.name} 👏👏👏"
      end_game
    end

    def winner?
      results = WINNING_COMBOS.map do |combo|
        combo.map.with_object([]) { |n, a| a << board[n - 1] }
      end

      results.any? { |r| r.uniq.length == 1 }
    end

    def check_for_draw
      return unless board.all? { |value| MARKERS.include?(value) }
      puts "No more moves available. The game is a draw."
      end_game
    end

    def end_game
      puts "Final Result:"
      display_board

      puts "GAME OVER"
      exit
    end
  end
end
