require_relative "player"
require_relative "board"

class Game
  MARKERS = ["🟢", "🔴"]

  attr_reader :board, :player_1, :player_2, :verbose_output
  attr_accessor :turn_count

  def initialize(
    player_1: Player.new("Player 1", MARKERS[0], true),
    player_2: Player.new("Player 2", MARKERS[1], true),
    board: Board.new(verbose_output: verbose_output),
    verbose_output: true
  )

    @player_1 = player_1
    @player_2 = player_2
    @board = board
    @verbose_output = verbose_output
    @turn_count = 0
  end

  def play
    display_introduction
    display_turn_order until game_over?
  end

  def display_turn_order
    @turn_count += 1
    board.display if verbose_output
    next_player_move
  end

  def next_player_move
    loop do
      column_number = get_player_input
      break if board.drop_piece(column_number, current_player.marker)
    end
  end

  def current_player
    turn_count.odd? ? player_1 : player_2
  end

  def game_over?
    if board.winner?(current_player.marker)
      display_winner
      true
    elsif board.full?(turn_count)
      display_draw
      true
    else
      false
    end
  end

  private

  def display_introduction
    puts <<~HEREDOC
      Welcome to Connect Four!
      The goal of the game is to be the first player to get four of your pieces in a row.
      The board is 6 rows high and 7 columns wide.
      The first player to go will be Player 1.
      The players will alternate turns.
      The first player to get four of their pieces in a row wins!
      If the board is full and no player has won, the game is a draw.

      Player 1 will be using #{player_1.marker}
      Player 2 will be using #{player_2.marker}

      GOOD LUCK!
    HEREDOC
  end

  def get_player_input
    if current_player.automated
      (0..6).to_a.sample
    else
      puts "It is #{current_player.name}'s turn. Please enter a column number between 1 and 7." if verbose_output
      gets.chomp.to_i - 1 # adjust for 0-indexed array
    end
  end

  def display_winner
    puts <<~HEREDOC

      #{current_player.name} #{current_player.marker} wins!

      #{board.display}

    HEREDOC
  end

  def display_draw
    puts <<~HEREDOC

      The game was a draw!

      #{board.display}

    HEREDOC
  end
end
