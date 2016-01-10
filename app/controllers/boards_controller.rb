class BoardsController < ApplicationController

  helper_method :show_valid_moves
  helper_method :draw_board
  helper_method :make_move

  def index
    @board = Board.new([1,0,0,0,0,0,0,0,0,0,0,0,0,0,0])
    session[:state] = @board.state
    redirect_to action: 'show'
  end

  def show
    @board = Board.new(session[:state])
    @move
  end

  def make_move
    @board = Board.new(session[:state])
    @move = params[:from].to_s + '.' + params[:to].to_s
    @jump = Board.get_jump(@move).to_s
    @move += '.' + @jump
    @board.make_move(@move)
    session[:state] = @board.state
    redirect_to action: 'show'
  end

  # Show valid moves defined for Board model
  def show_valid_moves
    Board.show_valid_moves
  end

  # Draw boards
  def draw_board
    @board.draw_board
  end

end
