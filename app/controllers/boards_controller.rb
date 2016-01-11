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

  # Set State No Peg In Top Position
  def set_state_top
    session[:state] = [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    redirect_to action: 'show'
  end

  # Set State No Peg In Bottom Right Position
  def set_state_right
    session[:state] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,1]
    redirect_to action: 'show'
  end

  # Set State No Peg In Bottom Left Position
  def set_state_left
    session[:state] = [0,0,0,0,0,0,0,0,0,0,1,0,0,0,0]
    redirect_to action: 'show'
  end

  # Set Multiple Random Missing Peg Positions
  def set_state_random_all
    session[:state] = [rand(2),rand(2),rand(2),rand(2),rand(2),rand(2),rand(2),rand(2),rand(2),rand(2),rand(2),rand(2),rand(2),rand(2),rand(2)]
    redirect_to action: 'show'
  end

  # Set Single Random Missing Peg Position
  def set_state_random_single
    random_state = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    random_state[rand(15)] = 1
    session[:state] = random_state
    redirect_to action: 'show'
  end

end
