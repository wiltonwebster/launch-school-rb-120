require 'pry'

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
  COMPUTER_NAMES = %w(Hal R2D2 Sonny Optimus Ultron)

  attr_accessor :marker, :score, :type, :name

  def initialize(name)
    @name = name
    @marker = nil
    @score = 0
  end

  def human?
    type == :human
  end

  def <=>(other_player)
    score <=> other_player.score
  end
end

class TTTGame
  WINNING_SCORE = 3

  attr_reader :board, :player1, :player2, :players
  attr_accessor :player_going_first, :current_player

  def initialize
    @board = Board.new
    @player1 = Player.new("Player 1")
    @player2 = Player.new("Player 2")
    @players = [@player1, @player2]
    @player_going_first = @players.sample
  end

  def play
    clear
    display_welcome_message
    initialize_players
    main_game
    display_goodbye_message
  end

  private

  def main_game
    loop do
      puts "First to #{WINNING_SCORE} points wins!"
      play_match
      display_match_result
      break unless play_again?
      match_reset
      display_play_again_message
    end
  end

  def play_match
    loop do
      play_round
      display_result
      update_scores
      break if winning_score_reached
      display_scores
      round_reset
    end
  end

  def play_round
    puts "#{player_going_first.name} goes first."
    self.current_player = player_going_first
    sleep(2)
    display_board
    loop do
      puts "It is #{current_player.name}'s turn."
      current_player_moves
      break if board.someone_won? || board.full?
      clear_screen_and_display_board
    end
  end

  def initialize_players
    num_humans = solicit_num_human_players
    initialize_human_player(player1)
    case num_humans
    when 1 then initialize_computer_player
    when 2 then initialize_human_player(player2)
    end
  end

  def solicit_num_human_players
    puts "How many people are playing?"
    answer = gets.chomp
    until %w(1 2).include?(answer)
      puts "Sorry, must choose 1 or 2."
      answer = gets.chomp
    end
    answer.to_i
  end

  def initialize_human_player(player)
    player.type = :human
    choose_name(player)
    choose_marker(player)
  end

  def initialize_computer_player
    player2.type = :computer
    player2.name = Player::COMPUTER_NAMES.sample
    player2.marker = player1.marker == 'O' ? 'X' : 'O'
  end

  def choose_name(player)
    puts "#{player.name} please enter your name:"
    input = gets.chomp
    player.name = input unless input.empty?
  end

  def choose_marker(player)
    puts "Please choose a letter to use as your marker:"
    input = nil
    loop do
      input = gets.chomp.upcase
      if !valid_marker?(input)
        puts "Invalid input. Please enter a single letter:"
      elsif duplicate_marker?(input)
        puts "That is #{player1.name}'s marker. Please choose another."
      else
        break
      end
    end
    player.marker = input
  end

  def valid_marker?(input)
    input.size == 1 && !!(input =~ /[A-Z]/)
  end

  def duplicate_marker?(input)
    input == player1.marker
  end

  def line_break
    puts ""
  end

  def joinor(list, delimiter = ', ', conjunction = 'or')
    case list.size
    when (0..1) then list.join
    when 2 then list.join(" #{conjunction} ")
    else list[0..-2].join(delimiter) + "#{delimiter}#{conjunction} #{list[-1]}"
    end
  end

  def clear
    system 'clear'
  end

  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
    line_break
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe! Goodbye!"
  end

  def display_board
    puts "#{player1.name}'s marker: #{player1.marker} | " \
         "#{player2.name}'s marker: #{player2.marker}"
    line_break
    board.draw
    line_break
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def current_player_moves
    if current_player.human?
      human_moves(current_player)
    else
      computer_moves
    end
    switch_current_player
  end

  def switch_current_player
    self.current_player = current_player == player1 ? player2 : player1
  end

  def human_moves(player)
    puts "Choose a square (#{joinor(board.unmarked_keys)}): "
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end

    board[square] = player.marker
  end

  def computer_moves
    puts "#{player2.name} is thinking..."
    sleep(4)
    computer_square_selection =
      computer_win || computer_block || computer_take_center ||
      board.unmarked_keys.sample
    board[computer_square_selection] = player2.marker
  end

  def center_available?
    board[5].unmarked?
  end

  def computer_win
    board.vulnerable_lines_with_squares.each do |line|
      if line.values.count { |square| square.marker == player2.marker } == 2
        return line.select { |_, v| v.unmarked? }.keys.first
      end
    end
    nil
  end

  def computer_block
    lines = board.vulnerable_lines_with_squares
    return if lines.empty?
    lines.first.select { |_, v| v.unmarked? }.keys.first
  end

  def computer_take_center
    5 if board[5].unmarked?
  end

  def display_result
    clear_screen_and_display_board

    case board.winning_marker
    when player1.marker
      puts "#{player1.name} won!"
    when player2.marker
      puts "#{player2.name} won!"
    else
      puts "It's a tie!"
    end
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

  def display_scores
    puts "#{player1.name}: #{player1.score} | " \
         "#{player2.name}: #{player2.score}"
  end

  def display_match_result
    case player1 <=> player2
    when -1
      puts "#{player2.name} won the match!"
    when 1
      puts "#{player1.name} won the match!"
    else
      puts "The match is a tie!"
    end
    display_final_score
  end

  def display_final_score
    puts "====================="
    puts "     FINAL SCORE     "
    puts "#{player1.name} - #{player1.score}"
    puts "#{player2.name} - #{player2.score}"
    puts "====================="
  end

  def winning_score_reached
    players.any? { |player| player.score >= WINNING_SCORE }
  end

  def play_again?
    answer = nil
    loop do
      puts "Rematch? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include?(answer)
      puts "Sorry, must be y or n."
    end

    answer == 'y'
  end

  def switch_who_goes_first
    self.player_going_first =
      player_going_first == player1 ? player2 : player1
  end

  def round_reset
    puts "Reseting the board..."
    sleep(4)
    board.reset
    switch_who_goes_first
    clear
  end

  def match_reset
    round_reset
    players.each { |player| player.score = 0 }
  end

  def display_play_again_message
    puts "Let's play again!"
    line_break
  end
end

game = TTTGame.new
game.play
