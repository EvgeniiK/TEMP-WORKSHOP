# Operations with cards
class Croupier

  # Returns the win combination
  def look(cards)
    @cards = sort_cards(cards)
    @response = { 'combo' => '', 'cards' => [] }
    @straight = check_straight(@cards)
    @flush = check_flush(@cards)
    if @straight != false
      @straight_flush = check_straight_flush(@straight)
      if @straight_flush != false
        if check_royal(@straight_flush)
          @response['combo'] = 'Royal flush'
        else
          @response['combo'] = 'Straight flush'
        end
        @response['cards'] = @straight_flush
        return @response
      end
    end
    @four_of_a_kind = check_four_of_a_kind(@cards)
    if @four_of_a_kind != false
      @response['combo'] = 'Four of a kind'
      @response['cards'] = @four_of_a_kind
      return @response
    end
    @full_house = check_full_house(@cards)
    if @full_house != false
      @response['combo'] = 'Full house'
      @response['cards'] = @full_house
      return @response
    end
    if @flush != false
      @response['combo'] = 'Flush'
      @response['cards'] = @flush
      return @response
    end
    if @straight != false
      @response['combo'] = 'Straight'
      @response['cards'] = @straight
      return @response
    end
    @three_of_a_kind = check_three_of_a_kind(@cards)
    if @three_of_a_kind != false
      @response['combo'] = 'Three of a kind'
      @response['cards'] = @three_of_a_kind
      return @response
    end
    @two_pairs = check_two_pairs(@cards)
    if @two_pairs != false
      @response['combo'] = 'Two pairs'
      @response['cards'] = @two_pairs
      return @response
    end
    @one_pair = check_one_pair(@cards)
    if @one_pair != false
      @response['combo'] = 'One pair'
      @response['cards'] = @one_pair
      return @response
    end
    @high_card = check_high_card(@cards)
    @response['combo'] = 'High card'
    @response['cards'] = @high_card
    @response
  end

  # Replace numbers 11/12/13/14 with J/Q/K/A
  def parse(win)
    parsed_win = []
    win['cards'].each do |card|
      parsed_card = { 'color' => '', 'type' => '' }
      case card['type']
      when 14
        parsed_card['type'] = 'A '
      when 13
        parsed_card['type'] = 'K '
      when 12
        parsed_card['type'] = 'Q '
      when 11
        parsed_card['type'] = 'J '
      when 10
        parsed_card['type'] = '10'
      else
        parsed_card['type'] = card['type'].to_s + ' '
      end
      parsed_card['color'] = card['color'] + ' '
      parsed_win.push(parsed_card)
    end
    parsed_win
  end

  private

  # Returns the high card
  def check_high_card(cards)
    win = []
    win.push(cards[6])
    win
  end

  # Returns "One pair" cards or false
  def check_one_pair(cards)
    kinds = parse_cards(cards)
    max = { 'type' => '', 'size' => 0 }
    kinds.each do |kind|
      if kind[1] > max['size']
        max['size'] = kind[1]
        max['type'] = kind[0].to_i
      end
    end
    return false unless max['size'] == 2
    win = []
    cards.each do |card|
      win.push(card) if card['type'] == max['type']
    end
    win
  end

  # Returns "Two pairs" cards or false
  def check_two_pairs(cards)
    kinds = parse_cards(cards)
    max = { 'type' => '', 'size' => 0 }
    kinds.each do |kind|
      if kind[1] > max['size']
        max['size'] = kind[1]
        max['type'] = kind[0].to_i
      end
    end
    if max['size'] == 2
      setups = []
      kinds.each do |kind|
        setups.push(kind) if kind[1] == max['size']
      end
    end
    if max['size'] == 2 && setups.length >= 2
      win = []
      cards.each do |card|
        if card['type'] == setups[0][0].to_i \
            || card['type'] == setups[1][0].to_i \
            || (!setups[2].nil? && card['type'] == setups[2][0].to_i)
          win.push(card)
        end
        break if win.length == 4
      end
      return win
    else
      return false
    end
  end

  # Returns "Three of a kind" cards or false
  def check_three_of_a_kind(cards)
    kinds = parse_cards(cards)
    max = { 'type' => '', 'size' => 0 }
    kinds.each do |kind|
      if kind[1] > max['size']
        max['size'] = kind[1]
        max['type'] = kind[0].to_i
      end
    end
    return false unless max['size'] == 3
    win = []
    cards.each do |card|
      win.push(card) if card['type'] == max['type']
    end
    win
  end

  # Returns "Full house" cards or false
  def check_full_house(cards)
    kinds = parse_cards(cards).sort { |x, y| y[1] <=> x[1] }
    counter = 1
    full_house = true
    setups = []
    dec_ones = 1
    kinds.each do |kind|
      if counter == 1
        if kind[1] != 3
          full_house = false
        else
          setups.push(kind)
        end
      end
      if counter == 2
        if kind[1] < 2
          full_house = false if dec_ones == 1
        elsif kind[1] == 3
          setups.push(kind)
        else
          setups.push(kind)
          counter -= dec_ones
          dec_ones = 0
        end
      end
      break if counter == 2
      counter += 1
    end
    if full_house == true
      win = []
      if setups.length == 2 && setups[1][1] == 3
        if setups[0][0].to_i >= setups[1][0].to_i
          @cards.each do |card|
            win.push(card) if card['type'] == setups[0][0].to_i
          end
          @cards.each do |card|
            win.push(card) if card['type'] == setups[1][0].to_i
            break if win.length == 5
          end
        else
          @cards.each do |card|
            win.push(card) if card['type'] == setups[1][0].to_i
          end
          @cards.each do |card|
            win.push(card) if card['type'] == setups[0][0].to_i
            break if win.length == 5
          end
        end
      elsif setups.length == 2 && setups[1][1] == 2
        @cards.each do |card|
          win.push(card) if card['type'] == setups[0][0].to_i
        end
        @cards.each do |card|
          win.push(card) if card['type'] == setups[1][0].to_i
          break if win.length == 5
        end
      else
        @cards.each do |card|
          win.push(card) if card['type'] == setups[0][0].to_i
        end
        if setups[1][0].to_i >= setups[2][0].to_i
          @cards.each do |card|
            win.push(card) if card['type'] == setups[1][0].to_i
            break if win.length == 5
          end
        else
          @cards.each do |card|
            win.push(card) if card['type'] == setups[2][0].to_i
            break if win.length == 5
          end
        end
      end
      return win
    else
      return false
    end
  end

  # Returns "Four of a kind" cards or false
  def check_four_of_a_kind(cards)
    kinds = parse_cards(cards)
    max = { 'type' => '', 'size' => 0 }
    kinds.each do |kind|
      if kind[1] > max['size']
        max['size'] = kind[1]
        max['type'] = kind[0].to_i
      end
    end
    return false unless max['size'] == 4
    win = []
    cards.each do |card|
      win.push(card) if card['type'] == max['type']
    end
    win
  end

  # Returns true if straight is Royal and false if no
  def check_royal(cards)
    return false unless cards[0]['type'] == 14
    true
  end

  # Returns "Straight flush" cards or false
  def check_straight_flush(cards)
    straight_flush = true
    color = @max['type']
    (0..4).each do |i|
      if cards[i]['color'] != color
        replace = false
        @cards.each do |card|
          if card['type'] == cards[i]['type'] && card['color'] == color
            replace = true
            cards[i]['color'] = color
          end
        end
        straight_flush = false if replace == false
      end
    end
    return false unless straight_flush == true
    cards
  end

  # Returns "Flush" cards or false
  def check_flush(cards)
    colors = { 'H' => 0, 'D' => 0, 'C' => 0, 'S' => 0 }
    cards.each do |card|
      colors[card['color']] += 1
    end
    @max = { 'size' => 0, 'type' => '' }
    colors.each do |color|
      if color[1] > @max['size']
        @max['size'] = color[1]
        @max['type'] = color[0]
      end
    end
    return false unless @max['size'] >= 5
    counter = 0
    win = []
    cards.reverse.each do |card|
      if card['color'] == @max['type']
        win.push(card)
        counter += 1
      end
      return win if counter == 5
    end
  end

  # Returns "Straight" cards or false
  def check_straight(cards)
    win = []
    counter = 0
    (1..(cards.length - 1)).to_a.reverse.each do |i|
      if (cards[i]['type'] - 1) == cards[i - 1]['type']
        counter += 1
        win.push(cards[i])
        cards[i]['straight'] = true
      else
        cards[i]['straight'] = false
        counter = 0
      end
      if counter == 4
        win.push(cards[i - 1])
        return win
      end
    end
    if cards[1]['straight'] == true
      win.push(cards[0])
      cards[0]['straight'] = true
    else
      cards[0]['straight'] = false
      win.push(cards[1]) if cards[2]['straight'] == true
    end
    return false unless win.length >= 5
    after_check = check_straight(win.reverse)
    return false unless after_check != false
    after_check
  end

  # Returns amount of cards of each type
  def parse_cards(cards)
    kinds = {}
    cards.each do |card|
      if kinds.include?(card['type'].to_s)
        kinds[card['type'].to_s] += 1
      else
        kinds[card['type'].to_s] = 1
      end
    end
    kinds
  end

  # Sorting cards
  def sort_cards(cards)
    cards.sort { |x, y| x['type'] <=> y['type'] }
  end

end
