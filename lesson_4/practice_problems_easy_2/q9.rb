# What would happen if we added a play method to the Bingo class, keeping in 
# mind that there is already a method of this name in the Game class that the
# Bingo class inherits from.

class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game
  def rules_of_play
    #rules of play
  end
end

# Adding a Bingo play method would cause that method to be executed instead of
# the Game play method when play is invoked on a Bingo object.