class Board
  attr_accessor :grid
  attr_reader :verbose_output, :columns, :rows, :win_streak

  def initialize(rows: 6, columns: 7, win_streak: 4, verbose_output: true)
    @rows = rows
    @columns = columns
    @grid = Array.new(@rows) { |i| Array.new(@columns) { "  " } }
    @win_streak = win_streak
    @verbose_output = verbose_output
  end

  def drop_piece(column, marker)
    return false unless valid_move?(column)

    @grid.each_with_index do |row, i|
      if available?(i, column)
        row[column] = marker
        break
      end
    end

    true
  end

  def winner?(marker)
    winning_rows?(marker) ||
      winning_columns?(marker) ||
      winning_diagonals?(marker)
  end

  def full?(turn_count)
    turn_count == rows * columns
  end

  def display
    # sleep 0.5
    rows = @grid.map { |row| row.map { |x| " " + x.to_s + " " }.join("|") }.reverse
    separator_rows = Array.new(@columns) { ("|----" * @columns)[1..] }
    footer_row = Array.new(@columns) { |i| " #{i + 1}  " }.join("|")

    puts
    puts rows.zip(separator_rows[1..]).compact.join("\n")
    puts footer_row
    puts
  end

  private

  def valid_move?(column)
    if !column.between?(0, @columns - 1)
      puts "Invalid input. Please enter a number between 1 and 7." if verbose_output
      false
    elsif column_full?(column)
      puts "That column is full. Please choose another column." if verbose_output
      false
    else
      puts "Valid move!" if verbose_output
      true
    end
  end

  def column_full?(column)
    !available?(@rows - 1, column)
  end

  def available?(row, col)
    grid[row][col].strip.empty?
  end

  def winning_rows?(marker)
    grid.any? do |row|
      row.each_cons(win_streak).any? { |group| group.all?(marker) }
    end
  end

  def winning_columns?(marker)
    grid.transpose.any? do |column|
      column.each_cons(win_streak).any? { |group| group.all?(marker) }
    end
  end

  def winning_diagonals?(marker)
    winning_diagonals.any? do |diagonal|
      grid.flatten.values_at(*diagonal).each_cons(win_streak).any? { |group| group.all?(marker) }
    end
  end

  def winning_diagonals
    [
      # Indexes of forward diagonals of at least 4 elements in a one dimensional 42 element array
      [0, 8, 16, 24, 32, 40],
      [1, 9, 17, 25, 33, 41],
      [2, 10, 18, 26, 34, 42],
      [3, 11, 19, 27, 35],
      [7, 15, 23, 31, 39],
      [14, 22, 30, 38],

      # Indexes of backward diagonals of at least 4 elements in a one dimensional 42 element array
      [3, 9, 15, 21],
      [4, 10, 16, 22, 28],
      [5, 11, 17, 23, 29, 35],
      [6, 12, 18, 24, 30, 36],
      [13, 19, 25, 31, 37],
      [20, 26, 32, 38]
    ]
  end
end
