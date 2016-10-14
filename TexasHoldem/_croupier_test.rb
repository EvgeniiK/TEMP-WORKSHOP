require_relative 'croupier.rb'

describe Croupier do

  before do
    @croupier = Croupier.new
  end

  describe "Combination" do

    it "should be royal flush" do
      cards = []
      cards.push('type' => 14, 'color' => 'S')
      cards.push('type' => 11, 'color' => 'S')
      cards.push('type' => 10, 'color' => 'S')
      cards.push('type' => 2, 'color' => 'S')
      cards.push('type' => 13, 'color' => 'S')
      cards.push('type' => 2, 'color' => 'D')
      cards.push('type' => 12, 'color' => 'S')

      result = @croupier.look(cards)

      expect(result['combo']).to eq("Royal flush")
    end

    it "should be straight flush" do
      cards = []
      cards.push('type' => 5, 'color' => 'D')
      cards.push('type' => 11, 'color' => 'S')
      cards.push('type' => 10, 'color' => 'S')
      cards.push('type' => 9, 'color' => 'S')
      cards.push('type' => 13, 'color' => 'S')
      cards.push('type' => 2, 'color' => 'D')
      cards.push('type' => 12, 'color' => 'S')

      result = @croupier.look(cards)

      expect(result['combo']).to eq("Straight flush")
    end

    it "should be four of a kind" do
      cards = []
      cards.push('type' => 5, 'color' => 'D')
      cards.push('type' => 5, 'color' => 'S')
      cards.push('type' => 10, 'color' => 'S')
      cards.push('type' => 9, 'color' => 'S')
      cards.push('type' => 5, 'color' => 'H')
      cards.push('type' => 2, 'color' => 'D')
      cards.push('type' => 5, 'color' => 'C')

      result = @croupier.look(cards)

      expect(result['combo']).to eq("Four of a kind")
    end

    it "should be full house" do
      cards = []
      cards.push('type' => 2, 'color' => 'S')
      cards.push('type' => 2, 'color' => 'D')
      cards.push('type' => 3, 'color' => 'D')
      cards.push('type' => 14, 'color' => 'C')
      cards.push('type' => 10, 'color' => 'H')
      cards.push('type' => 14, 'color' => 'H')
      cards.push('type' => 14, 'color' => 'S')

      result = @croupier.look(cards)

      expect(result['combo']).to eq("Full house")
    end

    it "should be flush" do
      cards = []
      cards.push('type' => 2, 'color' => 'H')
      cards.push('type' => 4, 'color' => 'H')
      cards.push('type' => 5, 'color' => 'S')
      cards.push('type' => 5, 'color' => 'H')
      cards.push('type' => 10, 'color' => 'H')
      cards.push('type' => 13, 'color' => 'H')
      cards.push('type' => 2, 'color' => 'D')

      result = @croupier.look(cards)

      expect(result['combo']).to eq("Flush")
    end

    it "should be straight" do
      cards = []
      cards.push('type' => 3, 'color' => 'H')
      cards.push('type' => 7, 'color' => 'D')
      cards.push('type' => 5, 'color' => 'S')
      cards.push('type' => 6, 'color' => 'C')
      cards.push('type' => 4, 'color' => 'C')
      cards.push('type' => 7, 'color' => 'S')
      cards.push('type' => 6, 'color' => 'D')

      result = @croupier.look(cards)

      expect(result['combo']).to eq("Straight")
    end

    it "should be three of a kind" do
      cards = []
      cards.push('type' => 12, 'color' => 'H')
      cards.push('type' => 11, 'color' => 'C')
      cards.push('type' => 2, 'color' => 'D')
      cards.push('type' => 12, 'color' => 'D')
      cards.push('type' => 5, 'color' => 'S')
      cards.push('type' => 7, 'color' => 'C')
      cards.push('type' => 12, 'color' => 'S')

      result = @croupier.look(cards)

      expect(result['combo']).to eq("Three of a kind")
    end

    it "should be two pairs" do
      cards = []
      cards.push('type' => 3, 'color' => 'H')
      cards.push('type' => 7, 'color' => 'C')
      cards.push('type' => 3, 'color' => 'D')
      cards.push('type' => 6, 'color' => 'H')
      cards.push('type' => 5, 'color' => 'S')
      cards.push('type' => 9, 'color' => 'S')
      cards.push('type' => 9, 'color' => 'C')

      result = @croupier.look(cards)

      expect(result['combo']).to eq("Two pairs")
    end

    it "should be one pair" do
      cards = []
      cards.push('type' => 3, 'color' => 'S')
      cards.push('type' => 5, 'color' => 'S')
      cards.push('type' => 14, 'color' => 'H')
      cards.push('type' => 3, 'color' => 'C')
      cards.push('type' => 11, 'color' => 'D')
      cards.push('type' => 7, 'color' => 'S')
      cards.push('type' => 4, 'color' => 'H')

      result = @croupier.look(cards)

      expect(result['combo']).to eq("One pair")
    end

    it "should be high card" do
      cards = []
      cards.push('type' => 2, 'color' => 'H')
      cards.push('type' => 4, 'color' => 'D')
      cards.push('type' => 6, 'color' => 'S')
      cards.push('type' => 8, 'color' => 'S')
      cards.push('type' => 10, 'color' => 'C')
      cards.push('type' => 12, 'color' => 'H')
      cards.push('type' => 14, 'color' => 'S')

      result = @croupier.look(cards)

      expect(result['combo']).to eq("High card")
    end

  end

end
