class BoardsController < ApplicationController

  include ApplicationHelper

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
    @jump = @board.get_jump(@move).to_s
    @move += '.' + @jump
    if @board.make_move(@move)
      session[:state] = @board.state
      redirect_to action: 'show'
    else
      flash[:error] = 'Invalid move - Please enter a valid move.'
    end
  end

  # Show valid moves defined for Board model
  def show_valid_moves
    #Board.show_valid_moves
    @board = Board.new(session[:state])
    @board.show_valid_moves
  end

  # Draw boards
  def draw_board
    @board.draw_board
  end

  # Set State No Peg In Top Position
  def set_state_top
    session[:state] = [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    flash[:success] = 'State changed successfully.'
    redirect_to action: 'show'
  end

  # Set State No Peg In Bottom Right Position
  def set_state_right
    session[:state] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,1]
    flash[:success] = 'State changed successfully.'
    redirect_to action: 'show'
  end

  # Set State No Peg In Bottom Left Position
  def set_state_left
    session[:state] = [0,0,0,0,0,0,0,0,0,0,1,0,0,0,0]
    flash[:success] = 'State changed successfully.'
    redirect_to action: 'show'
  end

  # Set Multiple Random Missing Peg Positions
  def set_state_random_all
    session[:state] = [rand(2),rand(2),rand(2),rand(2),rand(2),rand(2),rand(2),rand(2),rand(2),rand(2),rand(2),rand(2),rand(2),rand(2),rand(2)]
    flash[:success] = 'State changed successfully.'
    redirect_to action: 'show'
  end

  # Set Single Random Missing Peg Position
  def set_state_random_single
    random_state = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    random_state[rand(15)] = 1
    session[:state] = random_state
    flash[:success] = 'State changed successfully.'
    redirect_to action: 'show'
  end

end
