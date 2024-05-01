class Player
  attr_accessor :move, :name, :score, :is_round_winner, :is_match_winner
  attr_reader :move_history

  def initialize
    set_name
    @move_history = MoveHistory.new
    @is_round_winner = false
    @is_match_winner = false
    @score = Score.new
  end

  def winning_score?
    score.value >= 10
  end
end

class Human < Player
  def set_name
    user_name = nil
    loop do
      puts "What's your name?"
      user_name = gets.chomp
      break unless user_name.empty?
      puts 'Sorry, must enter a value.'
    end
    self.name = user_name
  end

  def choose
    choice = nil
    loop do
      puts 'Please choose Rock, Paper, Scissors, Spock, or Lizard:'
      choice = gets.chomp
      break if Move::VALUES.include?(choice.capitalize)
      puts 'Sorry, invalid choice.'
    end
    self.move = Move.const_get(choice.capitalize).new
  end
end

class Computer < Player
  BOTS = ['R2D2', 'SpockEXE', 'Hal', 'WOPR', 'Sentinel']

  def set_name
    self.name = self.class.to_s
  end

  def choose(_)
    self.move = Move.const_get(Move::VALUES.sample).new
  end
end

class R2D2 < Computer
end

class Hal < Computer
  def choose(human_choice)
    return super(human_choice) unless move
    choice = nil
    loop do
      choice = Move::VALUES.sample
      break unless choice == move.value
    end
    self.move = Move.const_get(choice).new
  end
end

class SpockEXE < Computer
  def set_name
    self.name = 'spock.exe'
  end

  def choose(_)
    choice = ['Spock', Move::VALUES.sample].sample
    self.move = Move.const_get(choice).new
  end
end

class WOPR < Computer
  def choose(human_choice)
    choice = nil
    loop do
      choice = Move::VALUES.sample
      break unless choice == human_choice.value
    end
    self.move = Move.const_get(choice).new
  end
end

class Sentinel < Computer
  def choose(human_choice)
    outcome = (1..5).to_a.sample
    self.move = case outcome
                when 1 then losing_move(human_choice)
                when 2 then drawing_move(human_choice)
                else winning_move(human_choice)
                end
  end

  def losing_move(human_choice)
    choice = nil
    loop do
      choice = Move.const_get(Move::VALUES.sample).new
      break if human_choice > choice
    end
    choice
  end

  def drawing_move(human_choice)
    human_choice.class.new
  end

  def winning_move(human_choice)
    choice = nil
    loop do
      choice = Move.const_get(Move::VALUES.sample).new
      break if choice > human_choice
    end
    choice
  end
end

class Score
  attr_accessor :value

  def initialize
    @value = 0
  end

  def to_s
    if value == 1
      '1 point'
    else
      "#{value} points"
    end
  end
end

class Move
  VALUES = ['Rock', 'Paper', 'Scissors', 'Spock', 'Lizard']

  attr_reader :value

  def initialize
    @value = self.class.to_s
  end

  def rock?
    value == 'Rock'
  end

  def paper?
    value == 'Paper'
  end

  def scissors?
    value == 'Scissors'
  end

  def spock?
    value == 'Spock'
  end

  def lizard?
    value == 'Lizard'
  end

  def to_s
    value
  end
end

class Rock < Move
  def >(other_move)
    other_move.scissors? || other_move.lizard?
  end
end

class Paper < Move
  def >(other_move)
    other_move.rock? || other_move.spock?
  end
end

class Scissors < Move
  def >(other_move)
    other_move.paper? || other_move.lizard?
  end
end

class Spock < Move
  def >(other_move)
    other_move.rock? || other_move.scissors?
  end
end

class Lizard < Move
  def >(other_move)
    other_move.paper? || other_move.spock?
  end
end

class MoveHistory
  attr_reader :list

  def initialize
    @list = Move::VALUES.each_with_object({}) { |move, hsh| hsh[move] = 0 }
  end

  def to_s
    output = ''
    list.each do |move, count|
      output += if count == 1
                  "  #{move} #{count} time\n"
                else
                  "  #{move} #{count} times\n"
                end
    end
    output
  end
end

class RPSGame
  attr_accessor :human, :computer, :players

  def initialize
    @human = Human.new
    @computer = Computer.const_get(Computer::BOTS.sample).new
    @players = [human, computer]
  end

  def play_again?
    answer = nil
    loop do
      puts 'Would you like to play again? (y/n)'
      answer = gets.chomp
      break if ['y', 'n'].include?(answer.downcase)
      puts 'Sorry, must be y or n.'
    end

    answer.downcase == 'y'
  end

  def play
    display_welcome_message

    loop do
      play_match
      break unless play_again?

      reset_scores
    end
    display_goodbye_message
  end

  def play_match
    loop do
      play_round
      break if match_winner?

      display_scores
    end
    determine_match_winner
    display_match_result
    display_move_histories
  end

  def play_round
    human.choose
    computer.choose(human.move)
    store_moves
    display_moves
    determine_winner
    update_scores
    display_winner
  end

  def display_welcome_message
    puts 'Welcome to Rock, Paper, Scissors, Spock, Lizard!'
    puts "Your opponent will be #{computer.name}."
  end

  def display_goodbye_message
    puts 'Thanks for playing Rock, Paper, Scissors, Spock, Lizard. Goodbye!'
  end

  def store_moves
    players.each { |player| player.move_history.list[player.move.to_s] += 1 }
  end

  def display_moves
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
  end

  def determine_winner
    human.is_round_winner = human.move > computer.move
    computer.is_round_winner = computer.move > human.move
  end

  def update_scores
    players.each do |player|
      player.score.value += 1 if player.is_round_winner
    end
  end

  def display_winner
    if human.is_round_winner
      puts "#{human.name} won!"
    elsif computer.is_round_winner
      puts "#{computer.name} won!"
    else
      puts "It's a tie!"
    end
  end

  def display_scores
    players.each do |player|
      puts "#{player.name} has #{player.score}."
    end
  end

  def match_winner?
    human.winning_score? || computer.winning_score?
  end

  def determine_match_winner
    players.each { |player| player.is_match_winner = player.winning_score? }
  end

  def display_match_result
    loser, winner = players.sort_by { |player| player.score.value }
    print_final_scoreboard(winner, loser)
    puts "#{winner.name} is the winner!"
  end

  def print_final_scoreboard(winner, loser)
    puts "====================="
    puts "     FINAL SCORE     "
    puts "#{winner.name} - #{winner.score}"
    puts "#{loser.name} - #{loser.score}"
    puts "====================="
  end

  def display_move_histories
    players.each do |player|
      puts "#{player.name} has chosen:"
      print player.move_history
    end
  end

  def reset_scores
    players.each { |player| player.score.value = 0 }
  end
end

RPSGame.new.play
