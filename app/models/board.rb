class Board
  include ActiveModel::Model

  #Position indexes starts at 0 for top position, then increments from top to bottom, going left to right.

  attr_accessor :state
  @state = :state

  # Get Valid Moves Array
  def valid_moves
    [[3,5],[6,8],[7,9],[0,5,10,12],[11,14],[0,3,12,14],[1,8],[2,9],[1,6],[2,7],[3,12],[4,13],[3,5,10,14],[4,11],[5,12]]
  end

  # Builds a list of valid moves for each position.
  def show_valid_moves
    @valid_moves = valid_moves
    @result = ''
    @valid_moves.each do |m|
      @result += "#{@valid_moves.index(m)}: "
      m.each do |v|
        @result += "#{v}"
        if m.index(v) < m.size-1
          @result += ', '
        end
      end
      @result += '<br>'
    end
    return @result
  end

  # Decodes 0 and 1 values in state array to o and x respectively for display
  def decode (value)
    value.to_s.sub(/[0]/,'o').sub(/[1]/,'x')
  end

  # Returns true if only one peg is remaining
  def is_solved
    self.state.count(0) == 1
  end

end