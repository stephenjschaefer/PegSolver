class Board
  include ActiveModel::Model

  attr_accessor :state

  # Decodes 0 and 1 values in state array to o and x respectively for display
  def decode (value)
    return(value.to_s.sub(/[0]/,'o').sub(/[1]/,'x'))
  end
end