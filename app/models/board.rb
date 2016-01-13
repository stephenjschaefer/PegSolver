class Board
  include ActiveModel::Model

  attr_accessor :state
  @@valid_moves = [[3,5],[6,8],[7,9],[0,5,10,12],[11,13],[0,3,12,14],[1,8],[2,9],[1,6],[2,7],[3,12],[4,13],[3,5,10,14],[4,11],[5,12]]
  @@valid_jumps = {:'0.3' => 1, :'0.5' => 2, :'1.6' => 3, :'1.8' => 4, :'2.7' => 4, :'2.9' => 5, :'3.0' => 1, :'3.5' => 4, :'3.10' => 6, :'3.12' => 7, :'4.11' => 7, :'4.13' => 8, :'5.0' => 2, :'5.3' => 4, :'5.12' => 8, :'5.14' => 9, :'6.1' => 3, :'6.8' => 7, :'7.2' => 4, :'7.9' => 8, :'8.1' => 4, :'8.6' => 7, :'9.2' => 5, :'9.7' => 8, :'10.3' => 6, :'10.12' => 11, :'11.4' => 7, :'11.13' => 12, :'12.3' => 7, :'12.5' => 8, :'12.10' => 11, :'12.14' => 13, :'13.4' => 8, :'13.11' => 12, :'14.5' => 9, :'14.12' => 13}

  # Initialize new boards instance.
  def initialize(state)
    @state = state
  end

  # Draw board.
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
      result += r  + '<br>'
    end
    return result
  end

  # Return count of number of valid moves for a given state.
  def get_valid_move_count
    result = self.get_valid_moves
    result.size
  end

  # Return count of number of pegs for a given state.
  def get_peg_count
    self.state.count(0)
  end

  # Returns the jumped peg position for a given move.
  def get_jump(move)
    @@valid_jumps[move.to_s.to_sym]
  end

  # Builds a list of all valid moves for each position.
  def show_all_valid_moves
    result = ''
    @valid_moves.each do |m|
      result += "#{@valid_moves.index(m)} => "
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

  # Builds an array of valid moves for the current board state.
  def get_valid_moves
    result = Array.new
    @@valid_moves.each do |f|
      f.each do |t|
        move = @@valid_moves.index(f).to_s + '.' + t.to_s
        jump = self.get_jump(move)
        move += '.' + jump.to_s
        if self.is_valid_move(move)
          result.unshift(move)
        end
      end
    end
    return result
  end

  # Builds a list of valid moves for the current board state for display.
  def show_valid_moves
    text = ''
    result = self.get_valid_moves
    result.reverse_each do |p|
      moveArray = self.parse_move(p)
      text += 'From ' + moveArray[0].to_s + ' to ' + moveArray[1].to_s + '<br>'
    end
    return text
  end

  # Decodes 0 and 1 values in state array to o and x respectively for display.
  def decode (value)
    value.to_s.sub(/[0]/,'o').sub(/[1]/,'x')
  end

  # Returns true if only one peg is remaining.
  def is_solved
    self.state.count(0) == 1
  end

  # Helper to parse a move string into an Integer array.
  def parse_move (value)
    value.split('.').map {|i| Integer(i)}
  end

  # Returns true if move is valid.
  # Move format is [From].[To].[Over] Ex => '3.0.1'.
  def is_valid_move (value)
    @move = self.parse_move(value)
    self.state[@move[0]] == 0 && self.state[@move[1]] == 1 && self.state[@move[2]] == 0
  end

  # Make a move.
  def make_move (value)
    if self.is_valid_move(value)
      @move = self.parse_move(value)
      self.state[@move[0]] = 1
      self.state[@move[1]] = 0
      self.state[@move[2]] = 1
      return true
    else
      return false
    end
  end

  # Make a move to build solution tree
  def make_move_solution (value, tree_state)
    if self.is_valid_move(value)
      @move = self.parse_move(value)
      tree_state[@move[0]] = 1
      tree_state[@move[1]] = 0
      tree_state[@move[2]] = 1
    end
  end

  # Build Solution Tree
  def build_solution (node, level)
    root_node = node
    tree_state = Array.new
    orig_state = Array.new
    temp_state = Array.new
    tree_state.replace(self.state)
    valid_moves = self.get_valid_moves

    valid_moves.each do |m|
      orig_state.replace(tree_state)
      temp_state.replace(tree_state)
      self.make_move_solution(m, temp_state)
      if !(temp_state == orig_state)
        root_node.add (Tree::TreeNode.new('LVL'+level+':'+m, tree_state))
      end
    end

    root_node.print_tree
  end

end