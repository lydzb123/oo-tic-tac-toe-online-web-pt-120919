class TicTacToe
require 'pry'
attr_reader :board

WIN_COMBINATIONS = [[0,1,2], #top-across
[3,4,5], #mid-across
[6,7,8], #btm-across
[0,3,6], #left-vert
[1,4,7], #mid-vert
[2,5,8], #rght-vert
[0,4,8], #diag-right
[6,4,2] #diag-left
]

def initialize(board = nil)
end

def display_board
  puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
  puts "-----------"
  puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
  puts "-----------"
  puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
end

def input_to_index(string)
  string.to_i - 1
end

def move(index, token = 'X')
  @board[index.to_i] = token
end

def position_taken?(index)
@board[index] == "X" || @board[index] == "O"
end

def valid_move?(index)
  index.between?(0,8) && !position_taken?(index)
end

def turn_count
  @board.count {|token| token == "X" || token == "O" }
end

def current_player
  if turn_count % 2 == 0
     "X"
   else
     "O"
   end

end


def turn
  puts "Please enter a number 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(index)
    move(index, current_player)
  else
    turn
  end
  display_board
end


def won?
   WIN_COMBINATIONS.any? do |combo|
     if position_taken?(combo[0]) && @board[combo[0]] == @board[combo[1]] && @board[combo[1]] == @board[combo[2]]
       return combo
     end
   end
    # WIN_COMBINATIONS.each do |combo|
    #   win_position_1 = combo[0]
    #   win_position_2 = combo[1]
    #   win_position_3 = combo[2]
    #
    #   board_token_1 = @board[win_position_1]
    #   board_token_2 = @board[win_position_2]
    #   board_token_3 = @board[win_position_3]
    #
    #   if board_token_1 == "X" && board_token_2 == "X" && board_token_3 == "X"
    #     return combo
    #   elsif board_token_1 == "O" && board_token_2 == "O" && board_token_3 == "O"
    #     return combo
    #   else
    #     false
    #   end
    #
    # end
    # false
end



def full?
  (board.count("X") + board.count("O") == 9) ? true : false
end


def draw?
full? && !won?
end


def over?
  won? || draw?
end

def winner
  if won?
    winning_spaces = won?
    @board[winning_spaces[0]]
  else
    return nil
  end
end

def play
 @board = Array.new(9, " ")
  while !over?
    turn
  end

  if won?
    puts "Congratulations #{winner}!"
  elsif draw?
    puts "Cat's Game!"
  end
end

end

game = TicTacToe.new
game.play
