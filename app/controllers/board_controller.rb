class BoardController < ApplicationController

  helper_method :show_valid_moves
  helper_method :draw_board

  def index
    @board = Board.new(state: [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0])
    session[:state] = @board.state
    redirect_to action: 'show'
  end

  def show
    #@board
    #@board = Board.new(state: [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0])
    #@board = Board
    #@valid_moves = Board  #@board.valid_moves
    #@show_valid_moves = @board.show_valid_moves
    #@test = 'test'
    #@is_solved = @board.is_solved
    #@is_valid_move = @board.is_valid_move()
    #
  end

  def make_move
    #@make_move = Board.make_move('3:1:0')
    #self.show
  end

  # Show valid moves defined for Board model
  def show_valid_moves
    Board.show_valid_moves
  end

  # Draw board
  def draw_board
    @board = Board.new(state: session[:state])
    @board.draw_board
  end
end
