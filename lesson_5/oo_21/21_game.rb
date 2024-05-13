module Hand
  def show_hand
    puts "---- #{name}'s Hand ----"
    cards.each do |card|
      puts "=> #{card}"
    end
    puts "=> Total: #{hand_total}"
    puts ""
  end

  def hand_total
    total = sum_card_values

    cards.select(&:ace?).count.times do
      break if total <= 21
      total -= 10
    end

    total
  end

  def sum_card_values
    sum = 0
    cards.each do |card|
      sum += case card
             when ace? then 11
             when face_card? then 10
             else
               card.face.to_i
             end
    end
    sum
  end

  def add_card(new_card)
    cards << new_card
  end

  def busted?
    hand_total > 21
  end
end

class Participant
  include Hand

  attr_accessor :name, :cards

  def initialize
    @cards = []
  end
end

class Player < Participant
  def initialize
    super
    set_name
  end

  def set_name
    name = ''
    loop do
      puts "What's your name?"
      name = gets.chomp
      break unless name.empty?
      puts "Sorry, you must enter a name:"
    end
    self.name = name
  end

  def show_flop
    show_hand
  end
end

class Dealer < Participant
  def initialize
    super
    @name = 'Dealer'
  end

  def show_flop
    puts "---- #{name}'s Hand ----"
    puts cards.first
    puts " ?? "
    puts ""
  end
end

class Deck
  attr_accessor :cards

  def initialize
    @cards = []
    Card::SUITS.each do |suit|
      Card::FACES.each do |face|
        @cards << Card.new(suit, face)
      end
    end

    shuffle!
  end

  def shuffle!
    cards.shuffle!
  end

  def deal_one
    cards.pop
  end
end

class Card
  FACES = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K']
  SUITS = ['H', 'D', 'S', 'C']
  FACE_CARDS = ['Jack', 'Queen', 'King']

  def initialize(suit, face)
    @suit = suit
    @face = face
  end

  def to_s
    "The #{face} of #{suit}"
  end

  def face
    case @face
    when 'J' then 'Jack'
    when 'Q' then 'Queen'
    when 'K' then 'King'
    when 'A' then 'Ace'
    else
      @face
    end
  end

  def suit
    case @suit
    when 'H' then 'Hearts'
    when 'D' then 'Diamonds'
    when 'S' then 'Spades'
    when 'C' then 'Clubs'
    end
  end

  def face_card?
    FACE_CARDS.include?(face)
  end

  def ace?
    face == 'Ace'
  end
end

class TwentyOne
  attr_accessor :deck, :player, :dealer

  def initialize
    @deck = Deck.new
    @player = Player.new
    @dealer = Dealer.new
  end

  def reset
    self.deck = Deck.new
    player.cards = []
    dealer.cards = []
  end

  def deal_cards
    2.times do
      player.add_card(deck.deal_one)
      dealer.add_card(deck.deal_one)
    end
  end

  def show_flop
    player.show_flop
    dealer.show_flop
  end

  def player_turn
    puts "#{player.name}'s turn..."

    loop do
      puts "Would you like to (h)it or (s)tay?"
      answer = gets.chomp.downcase
      loop do
        break if ['h', 's'].include?(answer)
        puts "Invalid entry. Please enter 'h' to hit or 's' to stay."
      end

      if answer == 's'
        puts "#{player.name} stays!"
        break
      elsif player.busted?
        break
      else
        player.add_card(deck.deal_one)
        puts "#{player.name} hits!"
        player.show_hand
        break if player.busted?
      end
    end
  end

  def dealer_turn
    puts "#{dealer.name}'s turn..."

    loop do
      if dealer.hand_total >= 17 && !dealer.busted?
        puts "#{dealer.name} stays!"
        break
      elsif dealer.busted?
        break
      else
        puts "#{dealer.name} hits!"
        dealer.add_card(deck.deal_one)
      end
    end
  end

  def show_busted
    if player.busted?
      puts "It looks like #{player.name} busted! #{dealer.name} wins!"
    elsif dealer.busted?
      puts "It looks like #{dealer.name} busted! #{player.name} wins!"
    end
  end

  def show_cards
    player.show_hand
    dealer.show_hand
  end

  def show_result
    if player.hand_total > dealer.hand_total
      puts "It looks like #{player.name} wins!"
    elsif player.hand_total < dealer.hand_total
      puts "It looks like #{dealer.name} wins!"
    else
      puts "It's a tie!"
    end
  end

  def play_again?
    puts "Would you like to play again? (y/n)"
    answer = gets.chomp.downcase
    loop do
      break if ['y', 'n'].include?(answer)
      puts "Please enter 'y' to play again or 'n' to stop playing."
      answer = gets.chomp.downcase
    end

    answer == 'y'
  end

  def start
    loop do
      system 'clear'
      deal_cards
      show_flop

      player_turn
      if player.busted?
        show_busted
        break unless play_again?
        reset
        next
      end

      dealer_turn
      if dealer.busted?
        show_busted
        break unless play_again?
        reset
        next
      end

      show_cards
      show_result
      play_again? ? reset : break
    end

    puts "Thank you for playing Twenty-One. Goodbye!"
  end
end

game = TwentyOne.new
game.start
