class BoardController < ApplicationController
  def show
    board = Board.new(state: [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0])
    @state = board.state
    @top = '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;_&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'
    @row1 = "&nbsp;&nbsp;&nbsp;&nbsp;/#{board.decode(@state[0])}\\&nbsp;&nbsp;&nbsp;&nbsp;"
    @row2 = "&nbsp;&nbsp;&nbsp;/#{board.decode(@state[1])} #{board.decode(@state[2])}\\&nbsp;&nbsp;&nbsp;"
    @row3 = "&nbsp;&nbsp;/#{board.decode(@state[3])} #{board.decode(@state[4])} #{board.decode(@state[5])}\\&nbsp;&nbsp;"
    @row4 = "&nbsp;/#{board.decode(@state[6])} #{board.decode(@state[7])} #{board.decode(@state[8])} #{board.decode(@state[9])}\\&nbsp;"
    @row5 = "/#{board.decode(@state[10])} #{board.decode(@state[11])} #{board.decode(@state[12])} #{board.decode(@state[13])} #{board.decode(@state[14])}\\"
    @bottom = '‾‾‾‾‾‾‾‾‾‾‾'
    @rows = [@top, @row1, @row2, @row3, @row4, @row5, @bottom]
  end
end
