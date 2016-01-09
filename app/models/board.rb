class Board
  include ActiveModel::Model

  attr_accessor :state
  @valid_moves = [[3,5],[6,8],[7,9],[0,5,10,12],[11,14],[0,3,12,14],[1,8],[2,9],[1,6],[2,7],[3,12],[4,13],[3,5,10,14],[4,11],[5,12]]

  # Initialize new board instance
  def initialize(state)
    @state = state
  end

  # Draw board
  def draw_board
    @board = self
    @state = @board.state
    result = ''
    top = '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;_&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'
    row1 = '&nbsp;&nbsp;&nbsp;&nbsp;/'+@board.decode(@state[0])+'\\&nbsp;&nbsp;&nbsp;&nbsp;'
    row2 = "&nbsp;&nbsp;&nbsp;/#{@board.decode(@state[1])} #{@board.decode(@state[2])}\\&nbsp;&nbsp;&nbsp;"
    row3 = "&nbsp;&nbsp;/#{@board.decode(@state[3])} #{@board.decode(@state[4])} #{@board.decode(@state[5])}\\&nbsp;&nbsp;"
    row4 = "&nbsp;/#{@board.decode(@state[6])} #{@board.decode(@state[7])} #{@board.decode(@state[8])} #{@board.decode(@state[9])}\\&nbsp;"
    row5 = "/#{@board.decode(@state[10])} #{@board.decode(@state[11])} #{@board.decode(@state[12])} #{@board.decode(@state[13])} #{@board.decode(@state[14])}\\"
    bottom = '‾‾‾‾‾‾‾‾‾‾‾'
    rows = [top, row1, row2, row3, row4, row5, bottom]
    rows.each do |r|
      result += r + '<br>'
    end
    return result
  end

  # Builds a list of valid moves for each position.
  def self.show_valid_moves
    result = ''
    @valid_moves.each do |m|
      result += "#{@valid_moves.index(m)}: "
      m.each do |v|
        result += "#{v}"
        if m.index(v) < m.size-1
          result += ', '
        end
      end
      result += '<br>'
    end
    return result
  end

  # Decodes 0 and 1 values in state array to o and x respectively for display
  def decode (value)
    value.to_s.sub(/[0]/,'o').sub(/[1]/,'x')
  end

  # Returns true if only one peg is remaining
  def is_solved
    self.state.count(0) == 1
  end

  # Helper to parse a move string into an Integer array
  def parse_move (value)
    value.split(/:/).map {|i| Integer(i)}
  end

  # Returns true if move is valid
  # Move format is [From]:[Over]:[To] Ex: '3:1:0'
  def is_valid_move (value)
    #@move = value.split(/:/).map {|i| Integer(i)}
    @move = self.parse_move(value)
    self.state[@move[0]] == 0 && self.state[@move[1]] == 0 && self.state[@move[2]] == 1
  end

  # Make a move
  def make_move (value)
    if self.is_valid_move(value)
      @move = self.parse_move(value)
      self.state[@move[0]] = 1
      self.state[@move[1]] = 1
      self.state[@move[2]] = 0
      #redirect_to action: 'show'
    else
      return false
    end
  end
end