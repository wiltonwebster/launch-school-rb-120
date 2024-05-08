module Displayable
  def clear
    system 'clear'
  end

  def clear_screen_and_display_score_and_board
    clear
    display_current_score
    display_board
  end

  def display_introduction
    display_general_rules
    display_marking_board_rules
    display_scoring_rules
    prompt "Press enter to begin the match."
    gets
    clear
    display_players
    display_who_goes_first
  end

  def display_general_rules
    prompt "Rules:"
    puts "The player going first will be randomly selected for the first round."
    puts "After that, the player going first will alternate every round."
    puts "Players will take turns marking one square at a time on the board."
    line_break
  end

  def display_marking_board_rules
    prompt "Marking the board:"
    puts "Each square is numbered:"
    display_example_board
    puts "To mark a square, enter the square's number."
    line_break
  end

  def display_example_board
    board.example
    display_board
    board.reset
  end

  def display_scoring_rules
    prompt "Scoring:"
    puts "Marking 3 squares in a row, column, or diagonal earns you 1 point."
    puts "If a round ends in a draw, both players earn half a point."
    puts "First player to #{TTTGame::WINNING_SCORE} points wins the match!"
    line_break
  end

  def display_players
    prompt "#{player1.name} vs. #{player2.name}"
  end

  def display_who_goes_first
    delay_animation("Selecting which player starts", 3)
    prompt "#{player_going_first.name} goes first!"
    delay_animation("Starting game", 3)
    clear
  end

  def display_board
    line_break
    board.draw
    line_break
  end

  def display_score_and_board
    display_current_score
    display_board
  end

  def display_result
    clear_screen_and_display_score_and_board

    case board.winning_marker
    when player1.marker
      prompt "#{player1.name} wins and earns a point!"
    when player2.marker
      prompt "#{player2.name} wins and earns a point!"
    else
      prompt "It's a tie! Each player earns half a point."
    end
  end

  def display_current_score
    puts "====================="
    puts "    CURRENT SCORE    "
    puts "#{player1.name} (#{player1.marker}) - #{player1.score}"
    puts "#{player2.name} (#{player2.marker}) - #{player2.score}"
    puts "====================="
    puts "First to #{TTTGame::WINNING_SCORE} point wins!"
  end

  def display_match_result
    delay_animation("The match is over! Tabulating results", 3)
    clear
    display_match_final_screen
  end

  def display_match_final_screen
    display_final_score
    case player1 <=> player2
    when -1
      prompt "#{player2.name} won the match!"
    when 1
      prompt "#{player1.name} won the match!"
    else
      prompt "The match is a tie!"
    end
  end

  def display_final_score
    puts "====================="
    puts "     FINAL SCORE     "
    puts "#{player1.name} - #{player1.score}"
    puts "#{player2.name} - #{player2.score}"
    puts "====================="
  end

  def display_welcome_message
    prompt "Welcome to Tic Tac Toe!"
    line_break
  end

  def display_play_again_message
    prompt "Let's play again!"
    line_break
  end

  def display_goodbye_message
    prompt "Thanks for playing Tic Tac Toe! Goodbye!"
  end
end

module Formattable
  def prompt(message)
    puts "=> #{message}"
  end

  def joinor(list, delimiter = ', ', conjunction = 'or')
    case list.size
    when (0..1) then list.join
    when 2 then list.join(" #{conjunction} ")
    else list[0..-2].join(delimiter) + "#{delimiter}#{conjunction} #{list[-1]}"
    end
  end

  def line_break
    puts ""
  end
end

module Animatable
  def delay_animation(message, seconds)
    print "=> #{message}"
    3.times do
      print "."
      sleep(seconds / 3)
    end
    line_break
  end
end

class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # columns
                  [[1, 5, 9], [3, 5, 7]]              # diagonals

  def initialize
    @squares = {}
    reset
  end

  def draw
    puts " #{@squares[1]} | #{@squares[2]} | #{@squares[3]}"
    puts '---+---+---'
    puts " #{@squares[4]} | #{@squares[5]} | #{@squares[6]}"
    puts '---+---+---'
    puts " #{@squares[7]} | #{@squares[8]} | #{@squares[9]}"
  end

  def [](number)
    @squares[number]
  end

  def []=(number, marker)
    @squares[number].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def example
    @squares.each { |key, square| square.marker = key.to_s }
  end

  def someone_won?
    !!winning_marker
  end

  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if three_identical_markers?(squares)
        return squares.first.marker
      end
    end
    nil
  end

  def vulnerable_lines_with_squares
    lines = find_vulnerable_lines
    map_lines_to_squares(lines)
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  private

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3
    markers.uniq.size == 1
  end

  def two_identical_markers?(squares)
    markers = squares.collect(&:marker)
    markers.uniq.size == 2
  end

  def exactly_one_unmarked?(squares)
    squares.select(&:unmarked?).size == 1
  end

  def find_vulnerable_lines
    WINNING_LINES.select do |line|
      squares = @squares.values_at(*line)
      two_identical_markers?(squares) && exactly_one_unmarked?(squares)
    end
  end

  def map_lines_to_squares(lines)
    lines.map do |line|
      @squares.select do |key, _|
        line.include?(key)
      end
    end
  end
end

class Square
  INITIAL_MARKER = ' '

  attr_accessor :marker

  def initialize(marker = INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end

  def marked?
    marker != INITIAL_MARKER
  end
end

class Player
  include Formattable, Animatable

  attr_accessor :marker, :score, :name, :opponent

  def initialize
    @marker = nil
    @score = 0
  end

  def <=>(other_player)
    score <=> other_player.score
  end

  private

  def duplicate_name?
    name == opponent.name
  end
end

class Human < Player
  def initialize(name)
    super()
    @name = name
  end

  def choose_name
    prompt "#{name} please enter your name:"
    self.name = gets.chomp
    loop do
      break if !too_long? && contains_alphanumeric? && !duplicate_name?
      name_error_prompt
      self.name = gets.chomp
    end
  end

  def choose_marker
    prompt "Please choose a letter to use as your marker:"
    self.marker = gets.chomp.upcase
    loop do
      break if valid_marker? && !duplicate_marker?
      marker_error_prompt
      self.marker = gets.chomp.upcase
    end
  end

  def move(board)
    prompt "Choose a square (#{joinor(board.unmarked_keys)}): "
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      prompt "Sorry, that's not a valid choice."
    end

    board[square] = marker
  end

  private

  def too_long?
    name.size > 10
  end

  def contains_alphanumeric?
    name.count("A-Za-z0-9") > 0
  end

  def name_error_prompt
    if too_long?
      prompt "Please enter a name that is 10 or fewer characters:"
    elsif !contains_alphanumeric?
      prompt "Please enter a name with at least 1 alphanumeric character:"
    elsif duplicate_name?
      prompt "Both players must have unique names. Please enter something else:"
    end
  end

  def valid_marker?
    marker.size == 1 && !!(marker =~ /[A-Z]/)
  end

  def duplicate_marker?
    marker == opponent.marker
  end

  def marker_error_prompt
    if !valid_marker?
      prompt "Invalid input. Please enter a single letter:"
    elsif duplicate_marker?
      prompt "That is #{opponent.name}'s marker. Please choose another."
    end
  end
end

class Computer < Player
  COMPUTER_NAMES = %w(Hal R2D2 Sonny Optimus Ultron)

  def choose_name
    self.name = COMPUTER_NAMES.sample
    loop do
      break unless duplicate_name?
      self.name = COMPUTER_NAMES.sample
    end
  end

  def choose_marker
    self.marker =
      if opponent.marker.nil? || opponent.marker == 'O'
        'X'
      else
        'O'
      end
  end

  def move(board)
    delay_animation("#{name} is thinking", 4)
    square_selection =
      win(board) || block(board) || take_center(board) ||
      board.unmarked_keys.sample
    board[square_selection] = marker
  end

  private

  def center_available?(board)
    board[5].unmarked?
  end

  def win(board)
    board.vulnerable_lines_with_squares.each do |line|
      if line.values.count { |square| square.marker == marker } == 2
        return line.select { |_, v| v.unmarked? }.keys.first
      end
    end
    nil
  end

  def block(board)
    lines = board.vulnerable_lines_with_squares
    return if lines.empty?
    lines.first.select { |_, v| v.unmarked? }.keys.first
  end

  def take_center(board)
    5 if board[5].unmarked?
  end
end

class TTTGame
  include Formattable, Displayable, Animatable

  WINNING_SCORE = 3

  attr_reader :board, :players, :player1, :player2
  attr_accessor :player_going_first, :current_player

  def initialize
    @board = Board.new
  end

  def play
    clear
    display_welcome_message
    initialize_players
    clear
    main_game
    display_goodbye_message
  end

  private

  def main_game
    display_introduction
    loop do
      play_match
      display_match_result
      break unless play_again?
      display_play_again_message
      match_reset
    end
  end

  def play_match
    loop do
      play_round
      display_result
      update_scores
      break if winning_score_reached
      round_reset
    end
  end

  def play_round
    display_score_and_board
    loop do
      prompt "It is #{current_player.name}'s turn."
      current_player_moves
      break if board.someone_won? || board.full?
      clear_screen_and_display_score_and_board
    end
  end

  def initialize_players
    num_humans = solicit_num_human_players
    create_players(num_humans)
    assign_game_attributes
    assign_player_attributes
  end

  def solicit_num_human_players
    prompt "How many people are playing?"
    answer = gets.chomp
    until %w(0 1 2).include?(answer)
      prompt "Sorry, must choose 1 or 2."
      answer = gets.chomp
    end
    answer.to_i
  end

  def create_players(num_humans)
    @player1 = if num_humans > 0
                 Human.new("Player 1")
               else
                 Computer.new
               end
    @player2 = if num_humans > 1
                 Human.new("Player 2")
               else
                 Computer.new
               end
  end

  def assign_game_attributes
    @players = [@player1, @player2]
    self.player_going_first = players.sample
    self.current_player = player_going_first
  end

  def assign_player_attributes
    player1.opponent = player2
    player2.opponent = player1

    players.each do |player|
      player.choose_name
      player.choose_marker
    end
  end

  def current_player_moves
    current_player.move(board)
    switch_current_player
  end

  def switch_current_player
    self.current_player = current_player == player1 ? player2 : player1
  end

  def update_scores
    case board.winning_marker
    when player1.marker
      player1.score += 1
    when player2.marker
      player2.score += 1
    else
      players.each { |player| player.score += 0.5 }
    end
  end

  def winning_score_reached
    players.any? { |player| player.score >= WINNING_SCORE }
  end

  def play_again?
    answer = nil
    loop do
      prompt "Rematch? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include?(answer)
      prompt "Sorry, must be y or n."
    end

    answer == 'y'
  end

  def switch_who_goes_first
    self.player_going_first =
      player_going_first == player1 ? player2 : player1
  end

  def round_reset
    delay_animation("Reseting the board", 3)
    board.reset
    switch_who_goes_first
    clear
  end

  def match_reset
    round_reset
    players.each { |player| player.score = 0 }
  end
end

game = TTTGame.new
game.play
