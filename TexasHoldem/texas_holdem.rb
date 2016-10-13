require_relative 'deck.rb'
require_relative 'croupier.rb'

deck = Deck.new
croupier = Croupier.new

cards = []

deck.shuffle(10)

7.times do
  cards.push(deck.get_card)
end

win = croupier.look(cards)

cards.sort { |x, y| x['type'] <=> y['type'] }.each do |card|
  puts card
end

puts '========================================'
puts win['combo']

win['cards'].each do |w|
  puts w
end
