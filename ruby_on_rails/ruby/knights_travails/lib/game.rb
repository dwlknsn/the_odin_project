require_relative "board"

class Game
  def initialize(board_size, start, finish)
    @board_size = board_size
    @start = start
    @finish = finish
    @board = Board.new(@board_size, @start, @finish)
  end

  def solve
    @board.setup
    @board.find_shortest_path
  end
end
