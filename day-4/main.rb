# data = File.open("input.txt")
# lines = data.readlines.map(&:chomp)

# drawn_numbers = lines[0]


WINNING_LINES = [[0, 1, 2, 3, 4], [5, 6, 7, 8, 9], [10, 11, 12, 13, 14], [15, 16, 17, 18, 19], [20, 21, 22, 23, 24], [0, 5, 10, 15, 20], [1, 6, 11, 16, 21], [2, 7, 12, 17, 22], [3, 8, 13, 18, 23], [4, 9, 14, 19, 24]]

def find_first_winner(boards)
  boards.each { |board| return board if won?(board) }
  nil
end

def won?(board)
  WINNING_LINES.any? { |line| line.none? { |open_square| board[open_square] } }
end

def find_all_winners(boards)
  boards.select { |board| won?(board) }
end

def mark_boards!(boards, move)
  boards.each { |board| board.map! { |square| square == move ? nil : square } }
end

def calculate_winning_sum(board, move)
  board_sum = board.compact.map! { |square| square.to_i }.inject(:+)
  board_sum * move.to_i
end

bingo_data = File.read('input.txt').split
bingo_moves = bingo_data.shift.split(",")
bingo_boards = bingo_data.each_slice(25).to_a

# part 1

winning_score = 0
bingo_moves.each do |move|
  mark_boards!(bingo_boards, move)
  winning_board = find_first_winner(bingo_boards)
  if winning_board
    winning_score = calculate_winning_sum(winning_board, move)
    break
  end
end
p winning_score

# part 2

winning_score = 0
bingo_moves.each do |move|
  mark_boards!(bingo_boards, move)
  winning_boards = find_all_winners(bingo_boards)
  unless winning_boards.empty?
    if bingo_boards.length == 1
      winning_score = calculate_winning_sum(bingo_boards[0], move)
      break
    else
      winning_boards.each { |board| bingo_boards.delete(board) }
    end
  end
end
p winning_score
