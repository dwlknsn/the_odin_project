require_relative "linked_list"

class Board
  MOVES = [
    [-2, -1],
    [-2, 1],
    [-1, -2],
    [-1, 2],
    [1, -2],
    [1, 2],
    [2, -1],
    [2, 1]
  ]

  def initialize(size, start, finish)
    @size = size
    @start = start
    @finish = finish
  end

  def setup
    puts "Solving for #{@start} to #{@finish} on an #{@size}x#{@size} board:"
    @board = generate_board

    @board[@start[0]][@start[1]] = "S"
    @board[@finish[0]][@finish[1]] = "F"
  end

  def find_shortest_path
    return unless valid_move?(@start)
    return unless valid_move?(@finish)

    queue = [LinkedList.new.append(Node.new(@start[0], @start[1]))]

    until queue.empty?
      current_path = queue.shift
      current_node = current_path.tail

      MOVES.each do |move|
        print "."
        x = current_node.x + move[0]
        y = current_node.y + move[1]

        next unless valid_move?([x, y])
        next if visited?(current_path, [x, y])

        if @finish == [x, y]
          current_path.append(Node.new(x, y))
          queue.clear
          break
        end

        queue << current_path.duplicate.append(Node.new(x, y))
        mark_as_visited([x, y])
      end
    end
    display_shortest_route(current_path)

    display_board
  end

  private

  def generate_board
    # rows
    Array.new(@size) do
      # columns
      Array.new(@size) do
        # placeholder value
        "-"
      end
    end
  end

  def valid_move?(position)
    position.all? { |x| x.between?(0, @size - 1) }
  end

  def visited?(path, position)
    # path.contains?(position)

    @board[position[0]][position[1]] == "."
  end

  def mark_as_visited(position)
    @board[position[0]][position[1]] = "."
  end

  def display_board
    rows = @board.map { |row| row.map { |x| " " + x.to_s + " " }.join("|") }
    separator_rows = Array.new(@size){ ("|---" * @size)[1..] }
    puts
    puts rows.zip(separator_rows[1..]).compact.join("\n")
    puts
  end

  def display_shortest_route(path)
    puts "\nShortest path: #{path}"

    current_node = path.head
    i = 1

    until current_node.nil?
      x, y = current_node.position
      @board[x][y] = i
      current_node = current_node.next_node
      i += 1
    end
  end
end
