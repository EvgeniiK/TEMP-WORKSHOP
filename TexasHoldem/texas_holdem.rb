require_relative 'deck.rb'
require_relative 'croupier.rb'

deck = Deck.new
croupier = Croupier.new

cards = []

deck.shuffle(10)

7.times do
  cards.push(deck.get_card)
end

parsed_cards = croupier.parse('cards' => cards)

win = croupier.look(cards)

parsed_win = croupier.parse(win)

puts '*******************************************************************'
puts '___________________________________________________________________'
print "\n"
print ' Your cards:'
15.times { print ' ' }
print 'Table:' + "\n"
puts '___________________________________________________________________'
print ' ------ ------ '
10.times { print ' ' }
5.times { print '------ ' }
print "\n"

print ' | '
print parsed_cards[0]['type']
print ' | | '
print parsed_cards[1]['type']
print ' | '
10.times { print ' ' }
print '| '
(2..5).each do |n|
  print parsed_cards[n]['type']
  print ' | | '
end
print parsed_cards[6]['type']
print ' |'
print "\n"

print ' |    | |    | '
10.times { print ' ' }
5.times { print '|    | ' }
print "\n"

print ' | '
print parsed_cards[0]['color']
print ' | | '
print parsed_cards[1]['color']
print ' | '
10.times { print ' ' }
print '| '
(2..5).each do |n|
  print parsed_cards[n]['color']
  print ' | | '
end
print parsed_cards[6]['color']
print ' |'
print "\n"

print ' ------ ------ '
10.times { print ' ' }
5.times { print '------ ' }
print "\n"
puts '___________________________________________________________________'
print "\n"
puts ' Your result - ' + win['combo'] + '!'
puts '___________________________________________________________________'

print ' '
parsed_win.length.times { print '------ ' }
print "\n"

print ' '
parsed_win.each do |card|
  print '| '
  print card['type']
  print ' | '
end
print "\n"

print ' '
parsed_win.length.times { print '|    | ' }
print "\n"

print ' '
parsed_win.each do |card|
  print '| '
  print card['color']
  print ' | '
end
print "\n"

print ' '
parsed_win.length.times { print '------ ' }
print "\n"
puts '___________________________________________________________________'
