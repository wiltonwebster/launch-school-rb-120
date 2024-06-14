# Number Guesser Part 1

class GuessingGame
  RANGE_MIN = 1
  RANGE_MAX = 100
  MAX_GUESSES = 7
  
  attr_accessor :remaining_guesses, :secret_number, :user_guess
  
  def initialize
    @remaining_guesses = nil
    @secret_number = nil
    @user_guess = nil
  end
  
  def play
    self.remaining_guesses = MAX_GUESSES
    select_secret_number
    loop do
      play_round
      break if user_won? || out_of_guesses?
    end
    display_game_result
  end
  
  def select_secret_number
    self.secret_number = rand(1..100)
  end
  
  def play_round
    display_num_guesses
    solicit_user_guess
    display_round_result
  end
  
  def display_num_guesses
    puts "You have #{remaining_guesses} guesses remaining."
  end
  
  def solicit_user_guess
    input = nil
    loop do
      print "Enter a number between #{RANGE_MIN} and #{RANGE_MAX}: "
      input = gets.chomp.to_i
      break if (RANGE_MIN..RANGE_MAX).include?(input)
      print "Invalid guess. "
    end
    self.user_guess = input
    self.remaining_guesses -= 1
  end

  def display_round_result
    case user_guess <=> secret_number
    when 1
      puts "Your guess is too high."
    when -1
      puts "Your guess is too low."
    when 0
      puts "That's the number!"
    end
    puts ""
  end
  
  def user_won?
    user_guess == secret_number
  end
  
  def out_of_guesses?
    remaining_guesses <= 0
  end
  
  def display_game_result
    if user_won?
      puts "You won!"
    else
      puts "You have no more guesses. You lost!"
    end
  end
end

game = GuessingGame.new
game.play