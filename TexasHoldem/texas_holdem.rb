require_relative 'deck.rb'
require_relative 'croupier.rb'

10000.times do
deck = Deck.new
croupier = Croupier.new

cards = []

deck.shuffle(10)

7.times do
  cards.push(deck.get_card)
end

=begin
test_hand = []
test_hand[0] = {'type' => 10, 'color' => 'H'}
test_hand[1] = {'type' => 9, 'color' => 'H'}
test_hand[2] = {'type' => 8, 'color' => 'H'}
test_hand[3] = {'type' => 7, 'color' => 'H'}
test_hand[4] = {'type' => 7, 'color' => 'D'}
test_hand[5] = {'type' => 6, 'color' => 'H'}
test_hand[6] = {'type' => 2, 'color' => 'H'}
=end

croupier.look(cards)

croupier.show_cards

end
