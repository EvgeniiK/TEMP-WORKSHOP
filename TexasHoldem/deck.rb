# Forming deck
class Deck
  # Creating deck
  def initialize
    @deck = []
    (2..14).each do |n|
      %w(H D C S).each do |c|
        @deck.push('type' => n, 'color' => c)
      end
    end
  end

  # Shuffle deck
  def shuffle(n = 1)
    n.times do
      @deck.shuffle!
    end
  end

  # Returns the top card of the deck
  def get_card
    @deck.pop
  end
end
