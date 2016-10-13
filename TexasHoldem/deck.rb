# Forming deck
class Deck
  def initialize
    @deck = []
    (2..14).each do |n|
      %w(H D C S).each do |c|
        @deck.push('type' => n, 'color' => c)
      end
    end
  end

  def shuffle(n = 1)
    n.times do
      @deck.shuffle!
    end
  end

  def get_card
    @deck.pop
  end
end
