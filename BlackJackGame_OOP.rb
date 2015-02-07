class Card
  attr_accessor:value,:suit
  def initialize(face_value = '',suit_value = '')
    @value = face_value
    @suit  = suit_value
  end
  def to_s
    return "Face value:#{value}. Suit:#{suit}"
  end

end


class Player
  attr_accessor:name,:scores
  def initialize(name = '')
    @name = name
    @scores = []
  end

  def calculate_scores(cards)
    arr = []
    cards.each do |card| arr << card.value
    end
    total = 0
    arr.each do |value|
    if value == "Ace"
      total += 11
    elsif value.to_i == 0 # J, Q, K
      total += 10
    else
      total += value.to_i
    end

    end
 #correct for Aces
    arr.select{|e| e == "Ace"}.count.times do
    total -= 10 if total > 21
    end

   total

  end
end

class Game
  attr_accessor:player,:computer,:cards

  def initialize
    @player = Player.new('Loc')
    @computer = Player.new('IBM')
    @cards = []
    card_number = ['2','3','4','5','6','7','8','9','10','Jack','Queen','King','Ace']
    card_type = ['spade','heart','club','diamond']
    card_number.each do |x|
    card_type.each do |x1|
      card = Card.new(x,x1)
      cards.push(card)
      cards.shuffle!
      end
    end
  end

  def compare_hands(player_scores,dealer_scores,stay='')
    message = ''
    if player_scores == 21 and player_scores > dealer_scores
      return "Player hits blackjack. Player wins"
    end
    if dealer_scores == 21 and dealer_scores > player_scores
      return "Dealer hits blackjack. Dealer wins"
    end
    if player_scores > 21
      return "You busted. You lost!"
    end
    if dealer_scores > 21
      return "Dealer busted. you won!"
    end
    if dealer_scores == player_scores && stay == 'stay'
      return "Its a tie!"
    end
    if dealer_scores > player_scores && stay == 'stay'
      return "Dealer wins"
    end
    if dealer_scores < player_scores && stay == 'stay'
      return " Player wins"
    end
    ''
  end

  def play
    player.scores<< cards.pop
    computer.scores << cards.pop
    player.scores << cards.pop
    computer.scores << cards.pop
    player.scores
    puts "Player two cards are: #{player.scores[0]} and #{player.scores[1]}. Total score:#{player.calculate_scores(player.scores)}"
    puts "Dealer two cards are: #{computer.scores[0]} and #{computer.scores[1]}. Total score:#{computer.calculate_scores(computer.scores)}"
    message = compare_hands(player.calculate_scores(player.scores),computer.calculate_scores(computer.scores))
    while message == ''
      begin
      puts "Would you like to continue ? :1 to continue and 2 to stop"
      choice=gets.chomp
      end while !['1', '2'].include?(choice)
      if choice == '1'
        new_card = cards.pop
        player.scores << new_card
        puts "Player new card is: #{new_card}. Total score:#{player.calculate_scores(player.scores)}"
        new_card = cards.pop
        computer.scores << new_card
        puts "Dealer new card is: #{new_card}. Total score:#{computer.calculate_scores(computer.scores)}"
        message = compare_hands(player.calculate_scores(player.scores),computer.calculate_scores(computer.scores))
      else
        while computer.calculate_scores(computer.scores) < 17
          new_card = cards.pop
          computer.scores << new_card
          puts "Dealer new card is: #{new_card}. Total score:#{computer.calculate_scores(computer.scores)}"
        end
        message=compare_hands(player.calculate_scores(player.scores),computer.calculate_scores(computer.scores),'stay')
      end
    end
    puts message
  end
end

game1 = Game.new()
game1.play
