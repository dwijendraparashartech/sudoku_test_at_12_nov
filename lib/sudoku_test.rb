class SudokuTest
  def initialize(board_string)
    @board = parse_board(board_string)
  end

  def parse_board(board)
    number_board = board.split("").map { |number_string| number_string.to_i }
    parsed_board = number_board.each_slice(9).to_a
  end

  def save_empty_positions(board)
    empty_positions = []
    for x in 0...board.length
      for y in 0...board[x].length
        if board[x][y] == 0
          empty_positions << [x, y]
        end
      end
    end
    empty_positions
  end

  def check_row(board, row, value)
    for y in 0...board[row].length
      if board[row][y] == value
        return false
      end
    end
    true
  end

  def check_column(board, column, value)
    for x in 0...board.length
      if board[x][column] == value
        return false
      end
    end
    true
  end

  def check_3x3_square(board, column, row, value)
    square_size = 3
    column_corner = square_size * (column / square_size)
    row_corner = square_size * (row / square_size)
    
    for x in row_corner...(row_corner + square_size)
      for y in column_corner...(column_corner + square_size)
        if board[x][y] == value
          return false
        end
      end
    end
    true
  end

  def check_value(board, column, row, value)
    return true if check_row(board, row, value) && check_column(board, column, value) && check_3x3_square(board, column, row, value)
    false
  end

  def solve_puzzle(board, empty_positions)
    limit = 9
    i = 0
    while i < empty_positions.length
      row = empty_positions[i][0]
      column = empty_positions[i][1]
      value = board[row][column] + 1
      found = false

      while !found && value <= limit
        if check_value(board, column, row, value)
          found = true
          board[row][column] = value
          i += 1
        else
          value += 1
        end
      end

      if !found
        board[row][column] = 0
        i -= 1
      end
    end
    return board
  end

  def solve!
    empty_positions = save_empty_positions(@board)
    @board = solve_puzzle(@board, empty_positions)
  end

  def board
    @board.map {|row| row.map(&:to_i).join(" ")}.join("\n")
    return @board
  end
end

obj = SudokuTest.new(data)
return obj.solve!

