class BoardController < ApplicationController

  helper_method :show_valid_moves
  helper_method :draw_board
  helper_method :make_move

  def index
    @board = Board.new([1,0,0,0,0,0,0,0,0,0,0,0,0,0,0])
    session[:state] = @board.state
    redirect_to action: 'show'
  end

  def show

  end

  def make_move
    @board = Board.new(session[:state])
    @board.make_move('3:1:0')
    session[:state] = @board.state
    redirect_to action: 'show'
  end

  # Show valid moves defined for Board model
  def show_valid_moves
    Board.show_valid_moves
  end

  # Draw board
  def draw_board
    @board = Board.new(session[:state])
    @board.draw_board
  end

end
