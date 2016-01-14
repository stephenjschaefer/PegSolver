class BoardsController < ApplicationController

  include ApplicationHelper

  helper_method :show_valid_moves
  helper_method :draw_board
  helper_method :make_move
  helper_method :build_solution

  # Initialize a new game.
  def index
    @board = Board.new([1,0,0,0,0,0,0,0,0,0,0,0,0,0,0])
    session[:state] = @board.state
    redirect_to action: 'show'
  end

  # Show board.
  def show
    @board = Board.new(session[:state])
    valid_move_count = @board.get_valid_move_count
    peg_count = @board.get_peg_count
    if valid_move_count == 0 || peg_count == 1
      if valid_move_count == 0 && peg_count > 1
        self.game_over_lose
      else
        self.game_over_win
      end
    end
    @move
    #Build Solution Tree
    @solution_count = build_solution

  end

  # Make a move.
  def make_move
    @board = Board.new(session[:state])
    if !params[:from].present? || !params[:to].present? || params[:from] == params[:to]
      flash[:error] = 'Invalid Move - Please Enter A Valid Move.'
    else
      @move = params[:from].to_s + '.' + params[:to].to_s
      @jump = @board.get_jump(@move).to_s
      if !@jump.present?
        flash[:error] = 'Invalid Move - Please Enter A Valid Move.'
      else
        @move += '.' + @jump
        if @board.make_move(@move)
          session[:state] = @board.state
          #redirect_to action: 'show'
        else
          flash[:error] = 'Invalid Move - Please Enter A Valid Move.'
        end
      end
    end
    redirect_to action: 'show'
  end

  # Show valid moves defined for Board model.
  def show_valid_moves
    @board = Board.new(session[:state])
    @board.show_valid_moves
  end

  # Draw board.
  def draw_board
    @board.draw_board
  end

  # Set State No Peg In Top Position.
  def set_state_top
    session[:state] = [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    flash[:success] = 'State changed successfully.'
    redirect_to action: 'show'
  end

  # Set State No Peg In Bottom Right Position.
  def set_state_right
    session[:state] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,1]
    flash[:success] = 'State changed successfully.'
    redirect_to action: 'show'
  end

  # Set State No Peg In Bottom Left Position.
  def set_state_left
    session[:state] = [0,0,0,0,0,0,0,0,0,0,1,0,0,0,0]
    flash[:success] = 'State changed successfully.'
    redirect_to action: 'show'
  end

  # Set Multiple Random Missing Peg Positions.
  def set_state_random_all
    session[:state] = [rand(2),rand(2),rand(2),rand(2),rand(2),rand(2),rand(2),rand(2),rand(2),rand(2),rand(2),rand(2),rand(2),rand(2),rand(2)]
    flash[:success] = 'State changed successfully.'
    redirect_to action: 'show'
  end

  # Set Single Random Missing Peg Position.
  def set_state_random_single
    random_state = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    random_state[rand(15)] = 1
    session[:state] = random_state
    flash[:success] = 'State changed successfully.'
    redirect_to action: 'show'
  end

  # Handle end of game loser.
  def game_over_lose
    flash[:error] = 'Game Over: Better Luck Next Time!'
  end

  # Handle end of game winner
  def game_over_win
    flash[:success] = 'Game Over: Great Job, You Won!'
  end

  # Build Solution
  def build_solution
    @board = Board.new(session[:state])
    root_node = Tree::TreeNode.new('ROOT', @board.state)
    @board.build_solution(root_node, 1, @board.state, 0)
  end

end
